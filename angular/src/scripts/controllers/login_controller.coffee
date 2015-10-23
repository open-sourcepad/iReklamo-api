'use strict'

angular.module('iReklamo').controller 'LoginCtrl',
  [ '$scope', '$state', '$modalInstance', 'RegistrationSvc', 'Password', 'Session',
   ( $scope,   $state,   $modalInstance,   RegistrationSvc,   Password,   Session ) ->

    $scope.reallyLogIn = ->
      RegistrationSvc.login { user: $scope.user }
        .$promise.then (data) ->
          Session.set data
          $scope.modal.dismiss()
        , ->
          swal "Bummer", "Unable to login in. Give it another try.", "error"

    $scope.modal =
      dismiss: ->
        $modalInstance.dismiss()
  ]
