angular.module('app').controller('RecoListCtrl',  [
  'Reco', 'rcoStore', '$location', '$routeParams', (Reco, rcoStore, $location, $routeParams) ->
    return new class RecoListCtrl
      constructor: () ->
        @recoStore = rcoStore
        if $routeParams.recommenderId?
          @recommender = $routeParams.recommenderId
          @filterList = @recoStore.getRecosByRecommender(@recommender)
        else if $routeParams.tagId?
          @tag = $routeParams.tagId
          @filterList = @recoStore.getRecosByTag(@tag)
        else if $routeParams.monthId?
          @month = $routeParams.monthId
          @meetingList = [{month: @month, recos: @recoStore.getRecosByMonth(@month)}]
          console.debug @meetingList
        else
          @meetingList = @recoStore.recosByDate

      gotoReco: (reco) ->
        $location.url "/reco/#{reco.id}"


])