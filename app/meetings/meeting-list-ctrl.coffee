angular.module('app').controller('MeetingListCtrl', [
  'Meeting', 'mtgStore', '$location', (Meeting, mtgStore, $location) ->
    return new class MeetingListCtrl
      constructor: () ->
        @store = mtgStore
        @thisMeeting = mtgStore.thisMeeting
        @futureMeetings = mtgStore.futureMeetings
        @pastMeetings = mtgStore.pastMeetings

      showDetail: (evt, id) ->
        return if evt.target.nodeName is 'A'
        $location.url "/meeting/#{id}"

])


