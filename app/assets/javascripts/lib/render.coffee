###

App.Render

This script provides functionalities for rendering.

It is also usefull for abstract the api for rendering things on the client
e.g. in the case of changing the render engine.

###

class window.App.Render

  @defaultPath: ""

  constructor: (template, data, options)->
    if typeof options == "string"
      options = JSON.parse options

    # console.log 'jsRender', {template, data, options, type: options?.field?()?.type}
    # debugger if template == "manage/views/items/field"

    # if options?.field?.attribute == 'room_id'
    #   options.field.type = 'autocomplete-search'

    return $.views.render["#{App.Render.defaultPath}#{template}"](data, options)

  @path: (template)=> "#{App.Render.defaultPath}#{template}"
