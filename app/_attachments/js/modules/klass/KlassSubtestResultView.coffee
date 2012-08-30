class KlassSubtestResultView extends Backbone.View

  events: 
    "click .run"           : "gotoRun"
    "click .back"          : "back"
    "click .show_itemized" : "showItemized"

  initialize: (options) ->
    #do nothing?

  showItemized: -> @$el.find(".itemized").fadeToggle()
  gotoRun: -> Tangerine.router.navigate "class/run/#{@options.student.id}/#{@options.subtest.id}", true
  back: -> Tangerine.router.navigate "class/#{@options.student.get("klassId")}/#{@options.subtest.get("part")}", true

  render: ->
    subtestItems = @options.subtest.get("items")

    resultHTML = "<br>"
    taken      = ""

    if @options.result.length != 0
      resultHTML += "<button class='command show_itemized'>#{t('itemized results')}</button><table class='itemized confirmation'><tbody><tr><th>Item</th><th>Result</th></tr>"
      for datum, i in @options.result[0].get("subtestData").items
        resultHTML += "<tr><td>#{datum.itemLabel}</td><td>#{t(datum.itemResult)}</td></tr>"
      resultHTML += "</tbody></table><br>"

      timestamp = new Date @options.result[0].get("timestamp")

      taken += "
        <tr>
          <td><label>#{t('taken')}</label></td><td>#{timestamp.getFullYear()}/#{timestamp.getMonth()+1}/#{timestamp.getDate()}</td>
        </tr>
      "

    @$el.html "
      <h1>Result</h1>
      <table class='info_box'><tbody>
        <tr>
          <td><label>Part</label></td>
          <td>#{@options.subtest.get("part")}</td>
        </tr>
        <tr>
          <td><label>Student</label></td>
          <td>#{@options.student.escape("name")}</td>
        </tr>
        <tr>
          <td><label>Subtest</label></td>
          <td>#{@options.subtest.escape("name")}</td>
        </tr>
        #{taken}
      </tbody></table>
      #{resultHTML}
      <div class='menu_box'>
        <img src='images/icon_run.png' class='run'>
      </div><br>
      <button class='navigation back'>Back</button>
    "

    @trigger "rendered"