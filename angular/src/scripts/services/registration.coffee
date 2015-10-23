angular.module('iReklamo')
  .service 'RegistrationSvc', [ '$resource', ($resource) ->

    $resource "/api/users/:id/:action", {},
      login:   { method: 'POST', params: { action: 'login' }}
  ]
