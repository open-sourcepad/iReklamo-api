angular.module('iReklamo').factory 'Session',
  [ '$sessionStorage', '$state', 'SessionSvc',
   ( $sessionStorage,   $state,   SessionSvc ) ->

    return null
  ]

angular.module('iReklamo').service 'SessionSvc', [ '$resource', ($resource) ->
  $resource "/api/v1/session"
]
