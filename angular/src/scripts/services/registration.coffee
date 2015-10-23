angular.module('iReklamo')
  .service 'RegistrationSvc', [ '$resource', ($resource) ->

    $resource "/api/customer/v1/registration/:id/:action", {},
      check:   { method: 'GET', params: { action: 'check' }}
      confirm: { method: 'POST', params: { action: 'confirm' }}
  ]
