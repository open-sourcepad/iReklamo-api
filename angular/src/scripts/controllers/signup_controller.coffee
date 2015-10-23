'use strict'

angular.module('iReklamo').controller 'SignupCtrl',
  [ '$scope', '$state', 'RegistrationSvc', 'Password', 'Session',
   ( $scope,   $state,   RegistrationSvc,   Password,   Session ) ->
     $scope.reallySignUp =() ->
      RegistrationSvc.save { user: $scope.user }
        .$promise.then (data) ->
          swal("ADDED TO DATABASE")
        , () ->
          swal("Unable to add user)

  ]
