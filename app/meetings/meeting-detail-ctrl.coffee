angular.module('app').controller('MeetingDetailCtrl', [
  'Meeting', 'mtgStore', '$scope', '$routeParams', (Meeting, mtgStore, $scope, $routeParams) ->
    return new class MeetingDetailCtrl
      constructor: () ->
        @store = mtgStore
        @meeting = mtgStore.getMeeting($routeParams.meetingId)

])