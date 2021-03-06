class MasteryCheckView extends Backbone.View

  initialize: (options) ->
    @results = options.results
    @student = options.student
    @klass = options.klass

    @resultsByPart = []
    bucketList = {}
    for result in @results.models
      bucketList[result.get("resultBucket")] = true
      part = result.get("part")
      @resultsByPart[part] = [] if not @resultsByPart[part]?
      @resultsByPart[part].push result
      @resultsByPart[part].sort (a, b) -> return a.attributes.reportType < b.attributes.reportType
    bucketList = _.keys(bucketList)

    # get current part since start
    milisecondsPerPart = 604800000
    @currentPart = Math.round(((new Date()).getTime() - @klass.get("startDate")) / milisecondsPerPart)


  render: ->
    html = "
      <h1>Mastery check report</h1>
      <h2>#{@student.get("name")}</h2>
      <table class='mastery_check'>
    "
    for part in [1..@currentPart]
      if @resultsByPart[part] == undefined then continue
      html += "<tr>"
      html += "<td>Week</td><td>#{part}</td>"

      for bucketResult in @resultsByPart[part]
        bucketName = bucketResult.attributes.resultBucket.titleize()
        correct = 0
        for item in bucketResult.attributes.subtestData.items
          correct++ if item.itemResult == "correct" 
        total   = bucketResult.attributes.subtestData.items.length
        
        html += "<td>#{bucketName} correct</td><td>#{correct}/#{total}</td>"
      
    html += "</table>"
    @$el.html html

    @trigger "rendered"
