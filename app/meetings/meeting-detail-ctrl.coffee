angular.module('app').controller('MeetingDetailCtrl', [
  'Meeting', 'mtgStore', '$routeParams', (Meeting, mtgStore, $routeParams) ->
    return new class MeetingDetailCtrl
      constructor: () ->
        @store = mtgStore
        @meeting = mtgStore.getMeeting($routeParams.meetingId)
        document.body.scrollTop = 0

])