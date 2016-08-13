###*
  * The meetingStore factory has a single property, a load() function.
  *
  * This function returns a promise that resolves to a singleton MeetingStore object.
###
angular.module('app').factory 'meetingStore', ['Meeting', 'googleSpreadsheetData', (Meeting, googleSpreadsheetData) ->

  class MeetingStore
    constructor: (meetingData) ->
      @futureMeetings = []
      @thisMeeting = null
      @pastMeetings = []


      dateCompare = (a,b) ->
        return -1 if !a.month? and b.month?
        return 1 if a.month? and !b.month?
        return 0 if !a.month? and !b.month?
        return 1 if a.month < b.month
        return -1 if a.month > b.month
        return 0
      @_meetings = (new Meeting(m) for m in meetingData).sort(dateCompare)

      # figure out which are current, past, and future meetings
      # current meeting is one that meets this month || next future month
      # unless it has a date (meeting date) more than 24 hours in the past
      now = new Date()
      yesterday = now - 86400000
      for m, idx in @_meetings
        if m.date?
          if m.date >= yesterday # it is still in the "future"
            @futureMeetings.push(m)
          else
            @pastMeetings.push(m)
        else
          mMonth = m.month.getMonth()
          mYear = m.month.getYear()
          nowMonth = now.getMonth()
          nowYear = now.getYear()
          # compare months
          if mYear is nowYear
            if mMonth >= nowMonth
              @futureMeetings.push(m)
            else
              @pastMeetings.push(m)
          else if mYear > nowYear
            @futureMeetings.push(m)
          else
            @pastMeetings.push(m)

      @futureMeetings.reverse()
      #this (i.e., next) meeting is the first future meeting
      @thisMeeting = @futureMeetings.shift()

      unless @thisMeeting? # make a TBD meeting
        @thisMeeting = new Meeting {
          title: 'TBD'
        }

      # make it easy to look up meetings by meetingId
      @_meetingHash = {}
      for m in @_meetings
        @_meetingHash[m.id] = m

    getMeeting: (meetingId) => return @_meetingHash[meetingId]

  # Google spreadsheet keys
  docId = '1JBruoPcv0lNNLqP8MtLgtLPYubHREutb1xZTmR0WMdE'
  sheetId = '1'
  columns = ['month', 'author', 'meetingdate', 'isbn', 'host', 'location', 'time', 'title']
  transform = (table) -> new MeetingStore(table)

  load = () -> return googleSpreadsheetData.load(docId, sheetId, columns, transform)

  return { load: load }


]