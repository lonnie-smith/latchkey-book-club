angular.module('app').controller('MeetingDetailCtrl', [
  'Meeting', 'mtgStore', '$routeParams', '$window', (Meeting, mtgStore, $routeParams, $window) ->
    return new class MeetingDetailCtrl
      constructor: () ->
        @store = mtgStore
        @meeting = mtgStore.getMeeting($routeParams.meetingId)
        document.body.scrollTop = 0

      goBack: (evt) ->
        # TODO - go to previous view, not just previous page.
        # this breaks if, e.g., this is the first page in the site you
        # have visited.
        evt.stopPropagation()
        $window.history.back()

])