angular.module('iReklamo').factory 'Password', ->
  regex: /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#\$%\^\&*\)\(+=._-]{8,}$/
  hint: 'is required and must be at least 8 characters long, contain one lowercase letter, one uppercase letter, and one number.'

angular.module('iReklamo').service 'PasswordSvc', [ '$resource', ($resource) ->
  $resource "/api/customer/v1/password/:id/:action", {},
    'update': { method: 'PATCH' }
]
