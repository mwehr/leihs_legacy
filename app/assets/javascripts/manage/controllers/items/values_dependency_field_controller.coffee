class window.App.ValuesDependencyFieldController extends Spine.Controller

  constructor: ->
    super
    @parentElement = @el.find("##{@parentField.id}")
    unless @renderData.itemData # in inventory helper there is no itemData
      @renderData.itemData = {}
    @rerenderChildElement()
    @parentElement.change =>
      @renderData.itemData[@childField.id] = null
      @rerenderChildElement()

  rerenderChildElement: =>
    @removeChildElement()
    @renderChildElement()

  removeChildElement: => @el.find("##{@childField.id}").remove()

  renderChildElement: =>
    console.log 'DO renderChildElement'
    @updateChildValues
      callback: =>
        console.log 'DO renderChildElement CALLBACK'
        @parentElement.after \
          App.Render \
            "manage/views/items/field", {}, $.extend(@renderData, { field: @childField })

  updateChildValues: ({callback}) =>
    parentValue = App.Field.getValue(@parentElement.find(".field[data-id]"))
    if parentValue
      url = @childField.values_url.replace("$$$parent_value$$$", parentValue)
      $.ajax
        url: url
        success: (data) =>
          @childField.values = @transformResponseData(data)
          callback()
          @callback?()

  transformResponseData: (data) =>
    res = _.map data, (el) => { value: el.id, label: el[@childField.values_label_method] }
    console.log 'done transformResponseData'
    res
