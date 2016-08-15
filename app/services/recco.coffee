angular.module('app').factory 'Recco', [() ->

  return class Recco
    constructor: ({month, @recommender, @title, tags, @description, @url}) ->
      @date = @_parseDate(month)
      @month = @_stringifyDate(@date)
      tags = tags.trim()
      tags = "Misc" if tags.length is 0
      @tags = tags.split(/\s*,\s*/)
      @primaryTag = @tags[0]
      @iconUrl = './img/' + @primaryTag.replace('/\s+/', '') + '.svg'

    _parseDate: (str) ->
      [m,d,y] = (parseInt(x,10) for x in str.split('/'))
      m = m - 1
      return new Date(y,m,d)

    _stringifyDate: (date) ->
      months = 'January February March April May June July August September October November December'.split(' ')
      return "#{months[date.getMonth()]} #{date.getFullYear()}"

]