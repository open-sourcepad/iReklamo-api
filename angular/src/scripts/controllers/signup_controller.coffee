'use strict'

angular.module('iReklamo').controller 'SignupCtrl',
  [ '$scope', '$state', '$modalInstance', 'RegistrationSvc', 'Password', 'Session',
   ( $scope,   $state,   $modalInstance,   RegistrationSvc,   Password,   Session ) ->

    $scope.reallySignUp = ->
      RegistrationSvc.save { user: $scope.user }
        .$promise.then (data) ->
          swal "Mabuhay", "Welcome to the iReklamo Community. #ParaSaBayan", "success"
          Session.set data
          $scope.modal.dismiss()
        , ->
          swal "Bummer", "Unable to sign up. Give it another try.", "error"

    $scope.modal =
      dismiss: ->
        $modalInstance.dismiss()

  ]
