angular.module('iReklamo').factory 'Garage',
  [ '$resource', '$filter',
   ( $resource,   $filter ) ->
    Garage = $resource '/api/customer/v1/garages/:id/:action',
      id: '@id'
    ,
      search: { isArray: true, method: 'GET', params: { action: 'search' }}
      info:   { isArray: false, method: 'GET', params: { action: 'info' }}

    Garage.prototype.rate = (unit, type = "Daily") ->
      return "-" unless this.pricing && this.pricing_intervals

      if unit == "month"
        interval = _.find this.pricing_intervals, { "interval_type": "Monthly" }
        rate =
          member: if interval then Math.round(interval.price) else "0"
      else
        rate = { start: "#{type}:", end: "", member: "0", non_member: "0" }
        pricing  = _.find(this.pricing, { days_of_week: { monday: "1"} })

        if pricing
          interval = _.find(this.pricing_intervals, { pricing_id: pricing.id, interval_type: type, enabled: true })
          rate = {
            start: moment.utc(interval.start_time).format("HH:mm")
            end: " - " + moment.utc(interval.end_time).format("HH:mm")
            member: Math.round interval.price
            non_member: Math.round interval.non_mbr_price
          } if interval

      rate

    Garage.prototype.hours = (day) ->
      pricing  = _.find this.pricing, (prc) ->
        prc.days_of_week[day] == "1"

      return "CLOSED" unless pricing

      hours = { start_time: "-", end_time: "-" }
      for i in _.filter(this.pricing_intervals, { pricing_id: pricing.id, unit: "day", enabled: true, })
        unless i.interval_type == "Hourly"
          hours.start_time = i.start_time if hours.start_time == "-" || i.start_time && hours.start_time > i.start_time
          hours.end_time = i.out_time if hours.end_time == "-" || i.out_time && hours.end_time < i.out_time

      moment.utc(hours.start_time).format("HH:mm") + " - " + moment.utc(hours.end_time).format("HH:mm")

    Garage
  ]
