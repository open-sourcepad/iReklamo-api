angular.module('iReklamo').factory 'Map',
  [ 'Garage', '$filter', '$rootScope', '$sessionStorage',
   ( Garage,   $filter,   $rootScope,   $sessionStorage ) ->

    map = null
    marker = null
    infoWindow = new google.maps.InfoWindow()
    maxZindex = google.maps.Marker.MAX_ZINDEX

    Map =
      new: (options) ->
        map = new GMaps
          div:    options.div
          center: options.center
          zoom:    17
          minZoom: 14
          maxZoom: 19
          styles: [{
            featureType: 'poi'
            elementType: 'labels'
            stylers: [
              visibility: 'off'
            ]
          }]

      addLabeledMarker: (garage, active, interval) ->
        color = if active then 'green' else 'blue'
        interval ||= 'day'

        if garage.latitude && garage.longitude
          mrkr = new RichMarker
            map: map.map
            position: new google.maps.LatLng(garage.latitude, garage.longitude)
            draggable: false
            flat: true
            content: """
              <div id="pin-#{garage.id}" class="map-pins #{color}-pin" title="#{garage.name}">
                <div class="price">
                  <div class="amount">$#{garage.rate(interval).member}</div>
                </div>
              </div>
            """

          google.maps.event.addListener mrkr, "click", (e) =>
            maxZindex += 1
            mrkr.setZIndex maxZindex

            infoWindow.close()
            infoWindow.setOptions
              content: this.markerInfo(garage)
              position: { lat: garage.latitude, lng: garage.longitude }
              pixelOffset: new google.maps.Size(0, -40)

            infoWindow.open map.map
            $rootScope.$emit "infoWindow", "opened"
            $sessionStorage.referrer = 'map'

      markerInfo: (g) ->
        """
        <div class='infowindow-scrollfix'>
          <span class='provider-name'><strong>#{g.service_provider_name}</strong></span><br>
          <strong>#{g.name}</strong><br>
          #{g.address1}<br>
          #{g.city}, #{g.postal_code}<br><br>
          <table class='table table-condensed table-striped'><thead><tr>
          <th>Pricing</th><th>Member</th><th>Non-member</th></tr>
          <tbody>
          <tr><td>Monthly</td><td colspan='2' class='text-center'>$#{g.rate('month').member}</td></tr>
          <tr><td>Early Bird</td><td class='text-right'>$#{g.rate('day', 'Early-Bird').member}</td><td class='text-right'>$#{g.rate('day', 'Early-Bird').non_member}</td></tr>
          <tr><td>Daily</td><td class='text-right'>$#{g.rate('day').member}</td><td class='text-right'>$#{g.rate('day').non_member}</td></tr>
          <tr><td>Evening</td><td class='text-right'>$#{g.rate('day', 'Evening').member}</td><td class='text-right'>$#{g.rate('day', 'Evening').non_member}</td></tr>
          </tbody></table>
          <a href='/#/garage/#{g.id}'>More Details</a>
        </div>
        """

      addPlaceMarker: (place) ->
        infoWindow.close()
        marker = new google.maps.Marker { map: map.map, anchorPoint: new google.maps.Point(0, -29) } unless marker
        marker.setVisible false

        return false unless place.geometry

        location = place.geometry.location
        map.setCenter location.lat(), location.lng()
        map.setZoom 17

        marker.setIcon
          url: place.icon
          size: new google.maps.Size(71, 71)
          origin: new google.maps.Point(0, 0)
          anchor: new google.maps.Point(17, 34)
          scaledSize: new google.maps.Size(35, 35)

        marker.setPosition place.geometry.location
        marker.setVisible true

        address = ''
        if place.address_components
          address = [
            (place.address_components[0] && place.address_components[0].short_name || ''),
            (place.address_components[1] && place.address_components[1].short_name || ''),
            (place.address_components[2] && place.address_components[2].short_name || '')
          ].join(' ')

        infoWindow.setOptions
          content: '<div><strong>' + place.name + '</strong><br>' + address
          pixelOffset: new google.maps.Size(0, 0)

        infoWindow.open map.map, marker

        { lat: location.lat(), lng: location.lng() }

    google.maps.Map::setPin = (garage, active = false, open = false) ->
      el = angular.element "#pin-#{garage.id}"
      el.trigger "click" if open

      if active
        el.addClass "green-pin"
      else
        el.removeClass "green-pin"

    google.maps.Map::refreshOverlay = (garage, interval) ->
      angular.element("#pin-#{garage.id} .amount").text "$" + garage.rate(interval).member

    google.maps.Map::getCurrentBoundRadius = ->
      bounds = this.getBounds()
      center = bounds.getCenter()
      ne = bounds.getNorthEast()
      # r = radius of the earth in statute miles
      r = 3963.0
      # Convert lat or lng from decimal degrees into radians (divide by 57.2958)
      lat1 = center.lat() / 57.2958
      lon1 = center.lng() / 57.2958
      lat2 = ne.lat() / 57.2958
      lon2 = ne.lng() / 57.2958
      # distance = circle radius from center to Northeast corner of bounds
      radius = r * Math.acos(Math.sin(lat1) * Math.sin(lat2) + Math.cos(lat1) * Math.cos(lat2) * Math.cos(lon2 - lon1))
      # convert to meters
      # radius = radius*1609.34

    google.maps.Map::drawRadiusDebugger = (radius) ->
      circleOptions =
        strokeColor:   "#FF0000"
        strokeOpacity: 0.4
        strokeWeight:  2
        fillColor:     "#FF0000"
        fillOpacity:   0.35
        map:           this
        center:        this.getCenter()
        radius:        radius * 1600

      new google.maps.Circle(circleOptions)

    return Map
  ]
