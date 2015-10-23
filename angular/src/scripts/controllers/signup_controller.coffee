'use strict'

angular.module('iReklamo').controller 'SignupCtrl',
  [ '$scope', '$state', 'RegistrationSvc', 'Password', 'Session',
   ( $scope,   $state,   RegistrationSvc,   Password,   Session ) ->
     $scope.reallySignUp =() ->
      RegistrationSvc.save { user: $scope.user }
        .$promise.then (data) ->
          swal("Able to sign up")
        , () ->
          swal("Unable to sign up")

  ]
