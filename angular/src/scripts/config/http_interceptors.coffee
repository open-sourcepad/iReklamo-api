# If a user is "logged in" (token is stored in the cookie), add the token value to the params hash.
angular.module('iReklamo').factory('addsAuthToken',
  [ '$sessionStorage', ($sessionStorage) ->

    request: (config) ->
      if $sessionStorage.authenticationToken
        if config.data?
          config.headers['ireklamo-app-token'] = $sessionStorage.authenticationToken
        else
          # Only for api requests
          if (config.url.slice(0, 4) == '/api')
            config.params = {} unless config.params
            config.headers['ireklamo-app-token'] = $sessionStorage.authenticationToken

      config
  ]
)

angular.module('iReklamo').factory('removesAuthTokenOnUnauthorized',
  [ '$q', '$sessionStorage', ($q, $sessionStorage) ->

    responseError: (rejection) ->
      if rejection.status == 401
        delete $sessionStorage.authenticationToken
        window.location.reload()

      return $q.reject(rejection)
  ]
)

angular.module('iReklamo').config ['$httpProvider', ($httpProvider) ->
  $httpProvider.interceptors.push('addsAuthToken')
  $httpProvider.interceptors.push('removesAuthTokenOnUnauthorized')
]
