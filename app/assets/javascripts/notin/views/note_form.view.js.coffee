Notin.NoteFormView = Backbone.View.extend
  events:
    'click .cancel': 'cancel'
    'submit form': 'save'

  initialize: ->
    @model = new Notin.Note unless @model

  render: ->
    @$el.html JST['note_form'](@model.toJSON())
    @$form = @$el.find 'form'
    this

  cancel: ->
    Notin.app.router.navigate('', true)
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
      success: _.bind((model) ->
        Notin.app.router.navigate('n/' + model.get('id'), true)
      , this)

    false


