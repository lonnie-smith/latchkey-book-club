angular.module('app').controller('ReccoDetailCtrl', [
  'rcoStore', 'Recco', '$routeParams', '$window', (rcoStore, Recco, $routeParams, $window) ->
    return new class ReccoDetailCtrl
      constructor: () ->
        @store = rcoStore
        @recco = rcoStore.getRecco($routeParams.reccoId)

      goBack: (evt) ->
        # TODO - go to previous view, not just previous page.
        # this breaks if, e.g., this is the first page in the site you
        # have visited.
        evt.stopPropagation()
        $window.history.back()

])