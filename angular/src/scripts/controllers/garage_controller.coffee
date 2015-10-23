'use strict'

angular.module('iReklamo').controller 'GarageCtrl',
  [ '$scope', '$state', '$stateParams', 'Garage', 'Session',
   ( $scope,   $state,   $stateParams,   Garage,   Session ) ->

    $scope.session =
      loggedIn: Session.online()
      contractable: RegState.get() > 3

    $scope.garage = Garage.get { id: $stateParams.garageId }
    Garage.info({ id: $stateParams.garageId }).$promise
      .then (data) ->
        $scope.garage.info = data
  ]
