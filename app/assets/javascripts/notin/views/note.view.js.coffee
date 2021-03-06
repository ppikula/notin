# Single note row on notes list.
Notin.NoteView = Backbone.View.extend
  className: 'note'
  events:
    mouseenter: 'showMenu'
    mouseover: 'showMenu'
    mouseleave: 'hideMenu'
    'click .delete': 'delete'
    'click .edit': 'edit'
    'click .open': 'toggle'
    'click .close': 'toggle'
    'dblclick .content': 'toggle'
    'dblclick .tags': 'toggle'
    'dblclick .created_at': 'toggle'
    dblclick: 'toggle'

  initialize: (options) ->
    @isStandAlone = options.isStandAlone || false

    @attributes = @decorateAttributes()

  render: ->
    @$el.attr('data-note-id', @attributes.id)

    if @isStandAlone
      @$el.addClass('standalone')

    @$el.html JST['note']($.extend(@attributes,
      isStandAlone: @isStandAlone
    ))

    @$controls = @$el.find('.control')
    @hideMenu()

    this

  decorateAttributes: ->
    attributes = @model.toJSON()
    attributes.created_at = $.format.date(attributes.created_at, 'dd-MM-yyyy HH:mm')
    attributes.content = @convertContent(attributes.content)
    attributes

  # @param [String] content
  # @return [String]
  convertContent: (content)->
    # Truncate
    if !@isStandAlone && content.length >= 400
      content = content.substring(0, 400) + ' &hellip;'

    # Process markdown
    converter = new Showdown.converter();
    converter.makeHtml(content);

  showMenu: (e) ->
    key.setTmpScope('note', $(e.currentTarget))
    @$controls.fadeIn 'slow'

  hideMenu: ->
    key.removeTmpScope()
    @$controls.hide() unless @isStandAlone

  toggle: (event) ->
    # Prevent action on text elements
    if $.inArray($(event.currentTarget).attr('class'), ["content", "tags", "created_at"]) == -1
      url = if @isStandAlone is true then '/' else '/n/' + this.attributes.id
      Notin.router.navigate(url, true)
    else
      false

  delete: ->
    Notin.router.navigate('/d/' + @attributes.id, true)

  edit: ->
    Notin.router.navigate('/e/' + @attributes.id, true)