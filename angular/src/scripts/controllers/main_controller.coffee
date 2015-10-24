'use strict'

angular.module('iReklamo').controller 'MainCtrl',
  [ '$scope', '$state', '$modal', 'Session',
   ( $scope,   $state,   $modal,   Session ) ->

    $scope.session = Session

    $scope.signUp = ->
      $modal.open(
        templateUrl: 'views/app/modals/sign_up.html'
        controller: 'SignupCtrl'
      )

    $scope.logIn = ->
      $modal.open(
        templateUrl: 'views/app/modals/login.html'
        controller: 'LoginCtrl'
      )

    $scope.logOut = ->
      Session.logout()

    $state.go 'dashboard.reklamo'
  ]
