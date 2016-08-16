angular.module('app').controller('ReccoListCtrl',  [
  'Recco', 'rcoStore', '$location', (Recco, rcoStore, $location) ->
    return new class ReccoListCtrl
      constructor: () ->
        @reccoStore = rcoStore

      gotoRecco: (recco) ->
        $location.url "/recco/#{recco.id}"
])