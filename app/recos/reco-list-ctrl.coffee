angular.module('app').controller('ReccoListCtrl',  [
  'Recco', 'rcoStore', '$location', '$routeParams', (Recco, rcoStore, $location, $routeParams) ->
    return new class ReccoListCtrl
      constructor: () ->
        @reccoStore = rcoStore
        if $routeParams.recommenderId?
          @recommender = $routeParams.recommenderId
          @filterList = @reccoStore.getReccosByRecommender(@recommender)
        else if $routeParams.tagId?
          @tag = $routeParams.tagId
          @filterList = @reccoStore.getReccosByTag(@tag)
        else if $routeParams.monthId?
          @month = $routeParams.monthId
          @meetingList = [{month: @month, reccos: @reccoStore.getReccosByMonth(@month)}]
          console.debug @meetingList
        else
          @meetingList = @reccoStore.reccosByDate

      gotoRecco: (recco) ->
        $location.url "/recco/#{recco.id}"


])