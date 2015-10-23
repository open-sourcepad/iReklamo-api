'use strict'

###*
# @ngdoc overview
# @name iReklamo
# @description
# # iReklamo
#
# Main module of the application.
###
app = angular.module 'iReklamo', [
  'ngAnimate'
  'ngCookies'
  'ngResource'
  'ngRoute'
  'ngSanitize'
  'ngTouch'
  'ui.bootstrap'
  'ui.router'
  'ngStorage'
]

app.run ($rootScope, $state, $window, Session) ->
  $rootScope.$on '$stateChangeStart', (event, state, params) ->
    if state.external
      event.preventDefault()
      window.open state.url, '_blank'

    # Undefined token = not a token, log out user
    # if state.data? and state.data.authenticate and !Session.online()
    #   event.preventDefault()
    #   $state.go "root.login"
