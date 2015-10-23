angular.module('iReklamo').factory 'Session',
  [ '$sessionStorage', '$state', 'SessionSvc',
   ( $sessionStorage,   $state,   SessionSvc ) ->

    logout: ->
      delete $sessionStorage.access_token

    online: ->
      if $sessionStorage.access_token then true else false

    set: (data) ->
      $sessionStorage.access_token = data.access_token
  ]

angular.module('iReklamo').service 'SessionSvc', [ '$resource', ($resource) ->
  $resource "/api/v1/session"
]
