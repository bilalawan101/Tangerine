class SubtestRunView extends Backbone.View
  
  events:
    "click .next"         : "next"
    "click .subtest_help" : "toggleHelp"

  toggleHelp: -> @$el.find(".enumerator_help").fadeToggle(250)

  initialize: (options) ->
    @protoViews  = Tangerine.config.prototypeViews
    @model       = options.model
    @parent      = options.parent

    @prototypeRendered = false

  render: ->
    
    # in case we hit a back button accidentally
    # window.onbeforeunload = => "Assessment is still running"

    enumeratorHelp = if (@model.get("enumeratorHelp") || "") != "" then "<button class='subtest_help command'>help</button><div class='enumerator_help'>#{@model.get 'enumeratorHelp'}</div>" else ""
    studentDialog  = if (@model.get("studentDialog")  || "") != "" then "<div class='student_dialog command'>#{@model.get 'studentDialog'}</div>" else ""

    @$el.html "
      <h2>#{@model.get 'name'}</h2>
      #{enumeratorHelp}
      #{studentDialog}
    "

    # Use prototype specific views here
    @prototypeView = new window[@protoViews[@model.get 'prototype']]
      model: @model
      parent: @
    @prototypeView.render()
    @$el.append @prototypeView.el
    @prototypeRendered = true

    @$el.append "<button class='next navigation'>Next</button>"

    @trigger "rendered"

  getGridScore: ->
    link = @model.get("gridLinkId") || ""
    if link == "" then throw "subtest grid link unspecified"; return
    grid = @parent.model.subtests.get @model.get("gridLinkId")
    gridScore = @parent.result.getGridScore grid.id
    gridScore 

  onClose: ->
    @prototypeView?.close?()

  isValid: ->
    if not @prototypeRendered then return false
    if @model.get("skippable") == true || @model.get("skippable") == "true"
      return true
    if @prototypeView.isValid?
      return @prototypeView.isValid()
    else
      return false
    true

  showErrors: ->
    @prototypeView.showErrors()

  getSum: ->
    if @prototypeView.getSum?
      return @prototypeView.getSum()
    else
      # maybe a better fallback
      return {correct:0,incorrect:0,missing:0,total:0}

  abort: ->
    @parent.abort()

  getResult: ->
    if @prototypeView.getResult?
      return @prototypeView.getResult()
    else
      return @$el.find("form").serializeSubtest()

  next: ->
    @parent.next()
  