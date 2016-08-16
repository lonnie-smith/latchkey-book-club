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

  $routeProvider.when '/reccos', {
    templateUrl: 'reccos/recco-list.html',
    controller: 'ReccoListCtrl'
    controllerAs: 'ctrl'
    resolve: {rcoStore: reccoStoreRouteResolver}
  }

  $routeProvider.when '/reccos/recommender/:recommenderId', {
    templateUrl: 'reccos/recco-list.html',
    controller: 'ReccoListCtrl'
    controllerAs: 'ctrl'
    resolve: {rcoStore: reccoStoreRouteResolver}
  }

  $routeProvider.when '/reccos/tag/:tagId', {
    templateUrl: 'reccos/recco-list.html',
    controller: 'ReccoListCtrl'
    controllerAs: 'ctrl'
    resolve: {rcoStore: reccoStoreRouteResolver}
  }

  $routeProvider.when '/reccos/month/:monthId', {
    templateUrl: 'reccos/recco-list.html',
    controller: 'ReccoListCtrl'
    controllerAs: 'ctrl'
    resolve: {rcoStore: reccoStoreRouteResolver}
  }

  $routeProvider.when '/recco/:reccoId', {
    templateUrl: 'reccos/recco-detail.html',
    controller: 'ReccoDetailCtrl',
    controllerAs: 'ctrl',
    resolve: {rcoStore: reccoStoreRouteResolver}
  }

  $routeProvider.otherwise {redirectTo: '/'}

]

# Route resolve promises
meetingStoreRouteResolver = (meetingStore) ->
  return meetingStore.load()
meetingStoreRouteResolver.$inject = ['meetingStore']

reccoStoreRouteResolver = (reccoStore) ->
  return reccoStore.load()
reccoStoreRouteResolver.$inject = ['reccoStore']