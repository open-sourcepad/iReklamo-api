'use strict'

angular.module('iReklamo').controller 'LoginCtrl',
  [ '$scope', '$state', 'RegistrationSvc', 'Password', 'Session',
   ( $scope,   $state,   RegistrationSvc,   Password,   Session ) ->
     $scope.reallyLogIn =() ->
      RegistrationSvc.login { user: $scope.user }
        .$promise.then (data) ->
          swal("Able to log in")
        , () ->
          swal("Unable to log in")

  ]
