angular.module('app').controller('ReccoListCtrl', [
  'Recco', 'rcoStore', (Recco, rcoStore) ->
    return new class ReccoListCtrl
      constructor: () ->
        @reccoStore = rcoStore

        console.debug @reccoStore.tagList
        # for name, recco of @reccoStore.recommenderIndex
        #   console.debug(name, recco.title)



])