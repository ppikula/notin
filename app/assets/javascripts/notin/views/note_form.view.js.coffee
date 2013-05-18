Notin.NoteFormView = Backbone.View.extend
  events:
    'click .cancel': 'cancel'
    'submit form': 'save'

  initialize: ->
    @model = new Notin.Note unless @model
    @on('render', @initCodeMirror)

  render: ->
    @$el.html JST['note_form'](@model.toJSON())
    @$form = @$el.find 'form'

    this

  cancel: ->
    Notin.router.navigate('', true)
    false

  save: (event) ->
    event.preventDefault()

    id = @$form.find('#id').val();

    @model.save
      id: (if id then id else null) # When ID is set, we're updating.
      title: @$form.find('#title').val()
      content: @$form.find('#content').val()
      tag_list: @$form.find('#tag_list').val()
    ,
      success: _.bind(->
        Notin.router.navigate('', true)
      , this)

    false

  initCodeMirror: ->
    Notin.editor = CodeMirror.fromTextArea(@$el.find('#content').get(0), {
      height: '100px'
      theme: 'ambiance'
    })



