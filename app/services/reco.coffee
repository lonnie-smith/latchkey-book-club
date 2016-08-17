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
      @id = @_stringifyShortDate(@date) + '-' + @idify(@title)

    _parseDate: (str) ->
      [m,d,y] = (parseInt(x,10) for x in str.split('/'))
      m = m - 1
      return new Date(y,m,d)

    _stringifyDate: (date) ->
      months = 'January February March April May June July August September October November December'.split(' ')
      return "#{months[date.getMonth()]} #{date.getFullYear()}"

    _stringifyShortDate: (date) ->
      return date.getFullYear() + '-' + (date.getMonth()+1)

    ###*
     * @param {String} str — string to convert
     * @return {String} — returns str converted to a human-readable "id form" good for passing as part of a URL: letters, characters, underscores, hyphens are preserved and returned as lowercase, all whitespace converted to hyphens, and everything else stripped out.
    ###
    idify: (str) ->
      return str.trim().toLowerCase().replace(/[^a-z0-9_\- ]+/g, '').replace(/\s+/g, '-')


]