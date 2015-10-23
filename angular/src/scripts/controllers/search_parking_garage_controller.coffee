'use strict'

angular.module('iReklamo').controller 'SearchParkingGarageCtrl',
  [ '$rootScope', '$scope', '$modal', '$filter', 'Map', 'Garage',
   ( $rootScope,   $scope,   $modal,   $filter,   Map,   Garage ) ->

    # =======================
    # Initialization
    # =======================

    map = null
    autocomplete = null
    modal = null
    lastEvent = undefined
    hasCentered = false
    hereMarker = { lat: 38.9029, lng: -77.0331 }
    oldMarker = null

    geolocatorOptions =
      enableHighAccuracy: true
      timeout: 5000
      maximumAge: 0

    $scope.busy = true
    $scope.garages = []
    $scope.garageIds = []
    $scope.proximity = 0
    $scope.preferences = {}
    $scope.preferences.selectedProviders = []
    $scope.providers = []
    $scope.user = null

    $scope.providerSettings =
      smartButtonMaxItems: 5
      enableSearch: true

    $scope.interval = 'day'
    $scope.$watch 'interval', (newInterval) ->
      if map
        angular.forEach $scope.garages, (garage) ->
          map.refreshOverlay garage, $scope.interval

    $rootScope.$on "infoWindow", (e, data) ->
      setHasCentered true

    $rootScope.$on "providersChanged", (e, data) ->
      angular.element(".map-pins").remove()
      drawMarkers $scope.garages, { pushGarage: false, pushId: false }

    $scope.search = ($event, form) ->
      $event.currentTarget[0].blur()

      if form.$valid
        Garage.search({ term: $scope.searchTerm }).$promise
          .then (garages) ->
            $scope.garages = garages
            $scope.garageIds.length = 0

            angular.element(".map-pins").remove()
            drawMarkers $scope.garages, { pushGarage: false, pushId: true }

    $scope.filteredGarages = ->
      $filter("garages")($scope.garages, $scope.preferences)

    $scope.showPreferences = () ->
      $modal.open(
        templateUrl: 'views/app/modals/global_preferences.html'
        controller: 'SearchPrefModalCtrl',
        scope: $scope
      )

    $scope.navigateToPin = (garage) ->
      setHasCentered true
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
        setHasCentered true
        ret = Map.addPlaceMarker autocomplete.getPlace()
        getGarages ret.lat, ret.lng, map.getCurrentBoundRadius() if ret

    addBoundsListener = ->
      map.addListener "bounds_changed", ->
        unless hasCentered
          lastEvent = new Date()
          setTimeout fireIfLastEvent, 500

    fireIfLastEvent = ->
      if lastEvent.getTime() + 500 <= new Date().getTime()
        center = map.getCenter()
        getGarages center.lat(), center.lng(), map.getCurrentBoundRadius()

    setHasCentered = (state) ->
      hasCentered = state
      setTimeout ->
        hasCentered = !state
      , 500

    addListeners = ->
      addBoundsListener()
      addAutoCompleteListener()

    geolocatorSuccess = (pos) ->
      hereMarker = { lat: pos.coords.latitude, lng: pos.coords.longitude }
      renderMap hereMarker.lat, hereMarker.lng

    geolocatorError = ->
      swal "Oops..", "We were not able to determine your current location. Using default location near Washington, DC..", "warning"
      renderMap hereMarker.lat, hereMarker.lng

    getUserSearchPrefs = ->
      ProfileSvc.get (data) ->
        $scope.r = data
        unless $.isEmptyObject(data.customer.search_preferences)
          $scope.preferences = data.customer.search_preferences
          $scope.preferences.selectedProviders = [] if data.customer.search_preferences.selectedProviders == null

    getServiceProviders = ->
      ProviderSvc.get().$promise.then (data) ->
        $scope.providers = data.service_providers

    getInitialLocation = ->
      navigator.geolocation.getCurrentPosition geolocatorSuccess, geolocatorError, geolocatorOptions

    getGarages = (lat, lng, radius) ->
      Garage.query({ lat: lat, lng: lng, proximity: radius, "cached_ids[]": $scope.garageIds }).$promise
        .then (data) ->
          clearGarages() if data.length == 0 && $scope.garageIds.length == 0
          drawMarkers data, { pushGarage: true, pushId: true }

    clearGarages = ->
      $scope.garages.length = 0
      $scope.garageIds.length = 0

    renderMap = (lat, long) ->
      $scope.busy = false

      map = Map.new { div: '#map', center: new google.maps.LatLng(lat, long) }
      map.addMarker { lat: lat, lng: long, title: "You are here." }
      addListeners()

    drawMarkers = (garages, options) ->
      angular.forEach garages, (garage) ->
        $scope.garages.push garage if options.pushGarage
        $scope.garageIds.push garage.id if options.pushId

      garages = $filter("garages")(garages, $scope.preferences)
      angular.forEach garages, (garage) ->
        Map.addLabeledMarker garage, false, $scope.interval

    # =======================
    # Let's roll ..
    # =======================

    getInitialLocation()
  ]
