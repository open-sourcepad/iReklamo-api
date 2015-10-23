angular.module('iReklamo').factory 'Complaint',
  [ '$resource', '$filter', ( $resource,   $filter ) ->

    $resource '/api/complaints/:id/:action', { id: '@id' },
      query: { isArray: false }
      search: { isArray: true, method: 'GET', params: { action: 'search' }}
      info:   { isArray: false, method: 'GET', params: { action: 'info' }}
  ]
