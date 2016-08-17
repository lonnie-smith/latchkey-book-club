angular.module('app').config ['$routeProvider', ($routeProvider) ->

  # Configure routes
  $routeProvider.when '/', {
    templateUrl: 'meetings/meeting-list.html',
    controller: 'MeetingListCtrl'
    controllerAs: 'ctrl'
    resolve: {mtgStore: meetingStoreRouteResolver}
  }

  $routeProvider.when '/meeting/:meetingId', {
    templateUrl: 'meetings/meeting-detail.html'
    controller: 'MeetingDetailCtrl'
    controllerAs: 'ctrl'
    resolve: {mtgStore: meetingStoreRouteResolver}
  }

  $routeProvider.when '/recos', {
    templateUrl: 'recos/reco-list.html',
    controller: 'RecoListCtrl'
    controllerAs: 'ctrl'
    resolve: {rcoStore: recoStoreRouteResolver}
  }

  $routeProvider.when '/recos/recommender/:recommenderId', {
    templateUrl: 'recos/reco-list.html',
    controller: 'RecoListCtrl'
    controllerAs: 'ctrl'
    resolve: {rcoStore: recoStoreRouteResolver}
  }

  $routeProvider.when '/recos/tag/:tagId', {
    templateUrl: 'recos/reco-list.html',
    controller: 'RecoListCtrl'
    controllerAs: 'ctrl'
    resolve: {rcoStore: recoStoreRouteResolver}
  }

  $routeProvider.when '/recos/month/:monthId', {
    templateUrl: 'recos/reco-list.html',
    controller: 'RecoListCtrl'
    controllerAs: 'ctrl'
    resolve: {rcoStore: recoStoreRouteResolver}
  }

  $routeProvider.when '/reco/:recoId', {
    templateUrl: 'recos/reco-detail.html',
    controller: 'RecoDetailCtrl',
    controllerAs: 'ctrl',
    resolve: {rcoStore: recoStoreRouteResolver}
  }

  $routeProvider.otherwise {redirectTo: '/'}

]

# Route resolve promises
meetingStoreRouteResolver = (meetingStore) ->
  return meetingStore.load()
meetingStoreRouteResolver.$inject = ['meetingStore']

recoStoreRouteResolver = (recoStore) ->
  return recoStore.load()
recoStoreRouteResolver.$inject = ['recoStore']