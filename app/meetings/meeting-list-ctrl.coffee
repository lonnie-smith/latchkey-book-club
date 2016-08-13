angular.module('app').controller('MeetingListCtrl', [
  'Meeting', 'mtgStore', (Meeting, mtgStore) ->
    return new class MeetingListCtrl
      constructor: () ->
        @store = mtgStore
        @thisMeeting = mtgStore.thisMeeting
        @futureMeetings = mtgStore.futureMeetings
        @pastMeetings = mtgStore.pastMeetings

])


