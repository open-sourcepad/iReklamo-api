'use strict'

angular.module('iReklamo').controller 'ReklamoCtrl',
  [ '$rootScope', '$scope', '$modal', '$filter', 'Map', 'Complaint', '$http'
   ( $rootScope,   $scope,   $modal,   $filter,   Map,   Complaint,  $http ) ->

    # =======================
    # Initialization
    # =======================

    map = null
    autocomplete = null
    lastEvent = undefined
    hasCentered = false
    oldMarker = null

    $scope.busy = true
    $scope.complaints = []
    $scope.complaintIds = []
    $scope.proximity = 0
    $scope.user = null

    $scope.providerSettings =
      smartButtonMaxItems: 5
      enableSearch: true

    $rootScope.$on "infoWindow", (e, data) ->
      reklamoMap.setHasCentered true

    $scope.reklamos = ->
      $scope.complaints

    $scope.search = ($event, form) ->
      $event.currentTarget[0].blur()

      if form.$valid
        Complaint.search({ term: $scope.searchTerm }).$promise
          .then (data) ->
            $scope.complaints = data.complaints
            $scope.complaintIds.length = 0

            angular.element(".map-pins").remove()
            reklamoMap.drawMarkers $scope.complaints, { pushGarage: false, pushId: true }

    $scope.navigateToPin = (garage) ->
      reklamoMap.setHasCentered true
      map.setCenter(garage.latitude, garage.longitude)

      map.setPin garage, true, true
      map.setPin oldMarker, false if oldMarker
      oldMarker = garage

    # =======================
    # Helper methods
    # =======================

    addAutoCompleteListener = ->
      autocomplete = new google.maps.places.Autocomplete angular.element("#search")[0]
      autocomplete.bindTo 'bounds', map

      google.maps.event.addListener autocomplete, 'place_changed', ->
        reklamoMap.setHasCentered true
        ret = Map.addPlaceMarker autocomplete.getPlace()
        fn.complaints.get ret.lat, ret.lng, map.getCurrentBoundRadius() if ret

    addBoundsListener = ->
      map.addListener "bounds_changed", ->
        unless hasCentered
          lastEvent = new Date()
          setTimeout fireIfLastEvent, 500

    fireIfLastEvent = ->
      if lastEvent.getTime() + 500 <= new Date().getTime()
        center = map.getCenter()
        fn.complaints.get center.lat(), center.lng(), map.getCurrentBoundRadius()

    fn =
      complaints:
        clear: ->
          $scope.complaints.length = 0
          $scope.complaintIds.length = 0

        get: (lat, lng, radius) ->
          Complaint.query { latitude: lat, longitude: lng, proximity: radius, "cached_ids[]": $scope.complaintIds }
            .$promise.then (data) ->
              fn.complaints.clearGarages() if data.length == 0 && $scope.complaintIds.length == 0
              reklamoMap.drawMarkers data.complaints, { pushComplaint: true, pushId: true }
            , (error) ->
              swal "Error"

    # ==================
    # reklamoMap
    # ==================
    reklamoMap =
      addListeners: ->
        addBoundsListener()
        addAutoCompleteListener()

      drawMarkers: (complaints, options) ->
        angular.forEach complaints, (data) ->
          $scope.complaints.push data.complaint if options.pushComplaint
          $scope.complaintIds.push data.complaint.id if options.pushId

        angular.forEach complaints, (data) ->
          Map.addLabeledMarker data.complaint, false

      render: (lat, long) ->
        $scope.busy = false

        map = Map.new { div: '#map', center: new google.maps.LatLng(lat, long) }
        map.addMarker { lat: lat, lng: long, title: "You are here." }
        this.addListeners()

      setHasCentered: (state) ->
        hasCentered = state
        setTimeout ->
          hasCentered = !state
        , 500

    # ==================
    # geoLocator
    # ==================
    geoLocator =
      marker: { lat: 14.5860022, lng: 121.06054659999998 }

      options:
        enableHighAccuracy: true
        timeout: 5000
        maximumAge: 0

      error: ->
        swal "Sorry!", "We were not able to determine your current location.", "warning"
        reklamoMap.render geoLocator.marker.lat, geoLocator.marker.lng

      success: (pos) ->
        geoLocator.marker = { lat: pos.coords.latitude, lng: pos.coords.longitude }
        reklamoMap.render geoLocator.marker.lat, geoLocator.marker.lng

      init: ->
        navigator.geolocation.getCurrentPosition this.success, this.error, this.options


    # =======================
    # Let's roll ..
    # =======================

    geoLocator.init()
  ]
