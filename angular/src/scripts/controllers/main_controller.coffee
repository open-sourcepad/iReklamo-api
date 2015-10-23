'use strict'

angular.module('iReklamo').controller 'MainCtrl',
  [ '$scope', '$state', ( $scope, $state ) ->

    $state.go 'dashboard.reklamo'
  ]
