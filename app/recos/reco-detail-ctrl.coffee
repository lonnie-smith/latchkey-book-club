angular.module('app').controller('RecoDetailCtrl', [
  'rcoStore', 'Reco', '$routeParams', '$window', (rcoStore, Reco, $routeParams, $window) ->
    return new class RecoDetailCtrl
      constructor: () ->
        @store = rcoStore
        @reco = rcoStore.getReco($routeParams.recoId)

      goBack: (evt) ->
        # TODO - go to previous view, not just previous page.
        # this breaks if, e.g., this is the first page in the site you
        # have visited.
        evt.stopPropagation()
        $window.history.back()

])