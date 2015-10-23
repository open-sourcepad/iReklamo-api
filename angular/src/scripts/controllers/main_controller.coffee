'use strict'

angular.module('iReklamo').controller 'MainCtrl',
  [ '$scope', '$state', '$modal', ( $scope, $state, $modal ) ->
     $scope.signUp = () ->
      $modal.open(
        templateUrl: 'views/app/modals/sign_up.html'
        controller: 'SignupCtrl'
      )

     $scope.logIn = () ->
      $modal.open(
        templateUrl: 'views/app/modals/login.html'
        controller: 'LoginCtrl'
      )

      $state.go 'dashboard.reklamo'
  ]
