'use strict'

angular.module('iReklamo').controller 'ReklamoShowCtrl',
  [ '$stateParams', '$scope', '$modal', '$filter', 'Map', 'Complaint',
   ( $stateParams,   $scope,   $modal,   $filter,   Map,   Complaint ) ->

    Complaint.get { id: $stateParams.id}
      .$promise.then (data) ->
        $scope.complaint = data.complaint
      , (error) ->
        swal "Sorry!", "Something gone awry. Bummer.", "error"
  ]
