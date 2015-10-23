'use strict'

angular.module('iReklamo').controller 'MainCtrl',
  [ '$scope', '$state', '$modal', ( $scope, $state, $modal ) ->
     $scope.signUp = () ->
      $modal.open(
        templateUrl: 'views/app/modals/sign_up.html'
        controller: 'SignupCtrl'
      )

      $state.go 'dashboard.reklamo'
  ]
