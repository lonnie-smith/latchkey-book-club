angular.module('app').factory 'reccoStore', ['Recco', 'googleSpreadsheetData', (Recco, googleSpreadsheetData) ->

  class ReccoStore
    constructor: (reccoData) ->
      @reccos = (new Recco(r) for r in reccoData)
      @_sortReccos()
      @reccosByDate = @_getReccosByDate()
      @tagIndex = @_buildTagIndex()
      @tagList = @_buildTagList()
      @recommenderIndex = @_buildRecommenderIndex()

    _sortReccos: () ->
      rSort = (a, b) ->
        if a.date > b.date
          return -1
        else if a.date < b.date
          return 1
        else
          if a.recommender < b.recommender
            return -1
          else if a.recommender > b.recommender
            return 1
          else
            if a.title < b.title
              return -1
            else if a.title > b.title
              return 1
            else
              return 0
      @reccos.sort(rSort)

    _getReccosByDate: () =>
      idx = {}
      for r in @reccos
        key = r.date.getTime()
        idx[key] ||= []
        idx[key].push(r)
      list = []
      for key in Object.keys(idx).sort().reverse()
        list.push {month: idx[key][0].month, reccos: idx[key]}
      return list

    _buildTagIndex: () =>
      idx = {}
      for r in @reccos
        for tag in r.tags
          idx[tag] ||= []
          idx[tag].push(r)
      return idx

    _buildRecommenderIndex: () =>
      idx = {}
      for r in @reccos
        idx[r.recommender] ||= []
        idx[r.recommender].push(r)
      return idx

    _buildTagList: () =>
      @tagIndex ||= @_buildTagIndex()
      return Object.keys(@tagIndex).sort()



  docId = '1JBruoPcv0lNNLqP8MtLgtLPYubHREutb1xZTmR0WMdE'
  sheetId = '2'
  columns = ['month', 'recommender', 'title', 'tags', 'description', 'url']
  transform = (table) -> new ReccoStore(table)
  load = () -> return googleSpreadsheetData.load(docId, sheetId, columns, transform)
  return { load: load }

]