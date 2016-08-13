angular.module('app').factory 'Meeting', ['$http', '$q', ($http, $q) ->

  return class Meeting
    constructor: ({month, meetingdate, @time, @host, @location, @title, @author, @isbn}) ->
      @month = @_parseDate(month) if month?.length > 0
      @date = @_parseDate(meetingdate) if meetingdate?.length > 0
      if @date
        @dateString = @_stringifyDate(@date)
      else
        @dateString = @_stringifyMonth(@month)
      @googleVolumeData = null
      @description = null
      @categories = null
      @imgUrl = null
      promise = @_fetchBookInfo()
      if promise?
        promise.then( ((data)=>console.debug(@imgUrl)) )
      else
        console.debug 'null promise for', @isbn
      for thing in ['time', 'host', 'location', 'title', 'author', 'isbn']
        this[thing] = this.thing?.trim?() if this.thing?.trim?
      @id = @_makeId()
      @buyLinks = @_makeBuyLinks()

    _parseDate: (str) ->
      [m,d,y] = (parseInt(x,10) for x in str.split('/'))
      m = m - 1
      return new Date(y,m,d)

    _stringifyDate: (date) ->
      months = 'January February March April May June July August September October November December'.split(' ')
      return "#{months[date.getMonth()]} #{date.getDate()}, #{date.getFullYear()}"

    _stringifyMonth: (date) ->
      months = 'January February March April May June July August September October November December'.split(' ')
      return months[date.getMonth()]

    _fetchBookInfo: () =>
      return null unless @isbn?.trim?().length >= 10
      url = "https://www.googleapis.com/books/v1/volumes?q=isbn:#{@isbn}"
      deferred = $q.defer()
      if @googleVolumeData?
        deferred.resolve(@googleVolumeData)
      else
        fetchSuccess = (result) =>
          @googleVolumeData = result.data.items[0]
          @categories = @googleVolumeData?.volumeInfo?.categories?.join(', ').toLowerCase()
          @description = @googleVolumeData?.volumeInfo?.description
          @imgUrl = @googleVolumeData?.volumeInfo?.imageLinks?.smallThumbnail || @googleVolumeData?.volumeInfo?.imageLinks?.thumbnail
          deferred.resolve(@googleVolumeData)
        fetchErr = (e) =>
          console.error(e)
          deferred.reject(e)
        $http({method: 'GET', url: url}).then(fetchSuccess, fetchErr)
      return deferred.promise

    _makeBuyLinks: () =>
      links = []
      return [] unless @author and @title
      return [
        {
          url: "http://catalog.kclibrary.org/client/en_US/kclibrary/search/results?qu=&qu=TITLE%3D#{@title.replace(/\s+/,'+')}+&qu=AUTHOR%3D#{@author.replace(/\s+/,'+')}"
          description: "KCPL"
        }
        {
          url: "http://www.rainydaybooks.com/search/site/#{@title.replace(/\s+/,'%20')}%20#{@author.replace(/\s+/,'%20')}"
          description: "Rainy Day"
        }

        {
          url: "http://www.powells.com/SearchResults?kw=any_words:#{@title.replace(/\s+/, '+')}&au=#{@author.replace(/\s+/, '+')}"
          description: "Powell’s"
        }

        {
          url: "http://www.abebooks.com/servlet/SearchResults?an=#{@author.replace(/\s+/, '+')}&sts=t&tn=#{@title.replace(/\s+/, '+')}"
          description: "AbeBooks"
        }

      ]

    _makeId: () =>
      id = @title?.trim?()?.toLowerCase().replace(/\s+|,|\.|:|;/g, '-')
      if id?
        if id.charAt(0) in '1234567890'.split('')
          id = "_"+id
        return id
      else
        return "title-tbd-#{(new Date()).getTime()}"

]