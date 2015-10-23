angular.module('iReklamo')
  .service 'RegistrationSvc', [ '$resource', ($resource) ->

    $resource "/api/users/:id/:action", {},
      login:   { method: 'GET', params: { action: 'login' }}
  ]
