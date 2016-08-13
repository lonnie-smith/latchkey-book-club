
angular.module('app').factory 'googleSpreadsheetData', ['$http', '$q', ($http, $q) ->

  #memoized data
  _cache = {}

  ###*
    Returns a promise which resolves to a memoized (cached) object.
    * @param {String} docId — Google workbook key
    * @param {String} sheetId — Tab within workbook
    * @param {Array} columns – list of columns to retrieve
    * @param {Function} transform — function that transforms the raw table data in to an object which will be cached. If `transform` is not defined, the raw table data will be returned.
    * @return {Promise}
  ###
  load = (docId, sheetId, columns, transform=null) ->
    key = "#{docId}+#{sheetId}"
    deferred = $q.defer()
    if _cache[key]?
      deferred.resolve(_cache[key])
    else
      fetchSuccess = (result) =>
        table = []
        for entry in result.data.feed.entry
          rowData = {}
          for colName in columns
            colKey = "gsx$#{colName}"
            unless entry[colKey]?
              msg = "column '#{colName}' not found."
              console.error(msg)
              deferred.reject(msg)
              return
            rowData[colName] = entry[colKey].$t
          table.push(rowData)
        if transform?
          _cache[key] = transform(table)
        else
          _cache[key] = table
        deferred.resolve(_cache[key])
      fetchErr = (e) => deferred.reject(e)

      url = "https://spreadsheets.google.com/feeds/list/#{docId}/#{sheetId}/public/values?alt=json"
      $http({method: 'GET', url: url}).then(fetchSuccess, fetchErr)

    return deferred.promise

  return { load: load }
]