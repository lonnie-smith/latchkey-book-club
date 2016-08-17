angular.module('app').factory 'recoStore', ['Reco', 'googleSpreadsheetData', (Reco, googleSpreadsheetData) ->

  class RecoStore
    constructor: (recoData) ->
      @recos = (new Reco(r) for r in recoData)
      @_sortRecos()
      @recosByDate = @_getRecosByDate()
      @tagIndex = @_buildTagIndex()
      @tagList = @_buildTagList()
      @recommenderIndex = @_buildRecommenderIndex()
      @idIndex = @_buildIdIndex()
      @monthIndex = @_buildMonthIndex()

    _sortRecos: () ->
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
      @recos.sort(rSort)

    _getRecosByDate: () =>
      idx = {}
      for r in @recos
        key = r.date.getTime()
        idx[key] ||= []
        idx[key].push(r)
      list = []
      for key in Object.keys(idx).sort().reverse()
        list.push {month: idx[key][0].month, recos: idx[key]}
      return list

    _buildTagIndex: () =>
      idx = {}
      for r in @recos
        for tag in r.tags
          idx[tag] ||= []
          idx[tag].push(r)
      return idx

    _buildRecommenderIndex: () =>
      idx = {}
      for r in @recos
        idx[r.recommender] ||= []
        idx[r.recommender].push(r)
      return idx

    _buildMonthIndex: () =>
      idx = {}
      for r in @recos
        idx[r.month] ||= []
        idx[r.month].push(r)
      return idx

    _buildIdIndex: () =>
      idx = {}
      idx[r.id] = r for r in @recos
      return idx

    _buildTagList: () =>
      @tagIndex ||= @_buildTagIndex()
      return Object.keys(@tagIndex).sort()

    ###*
     * @param {String} id — id of recommendation to return
     * @return {Reco} — reco matching `id` or `undefined`
    ###
    getReco: (id) => return @idIndex[id]

    ###*
     * @param {String} recommender
     * @return {Array} array of recommendations
    ###
    getRecosByRecommender: (recommender) => @recommenderIndex[recommender]

    ###*
     * @param {String} tag
     * @return {Array} array of recommendations
    ###
    getRecosByTag: (tag) => @tagIndex[tag]

    ###*
     * @param {String} month
     * @return {Array} array of recommendations
    ###
    getRecosByMonth: (month) =>
      console.debug @monthIndex[month]
      @monthIndex[month]





  docId = '1JBruoPcv0lNNLqP8MtLgtLPYubHREutb1xZTmR0WMdE'
  sheetId = '2'
  columns = ['month', 'recommender', 'title', 'tags', 'description', 'url']
  transform = (table) -> new RecoStore(table)
  load = () -> return googleSpreadsheetData.load(docId, sheetId, columns, transform)
  return { load: load }

]