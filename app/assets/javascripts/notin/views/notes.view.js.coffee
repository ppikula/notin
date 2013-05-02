Notin.NotesView = Backbone.View.extend
  initialize: (options) ->
    @keywords = options.keywords || ''

    @initializeNotes()

  render: ->
    @$el.html JST['notes']
    this

  renderNotes: ->
    @$notes = @$el.find '#notes'
    @$notes.html ''

    @notes.forEach(@renderNote, this)

  renderNote: (note) ->
    noteView = new Notin.NoteView(model: note)
    @$notes.append(noteView.render().$el)

  initializeNotes: ->
    @notes = new Notin.Notes
    @notes.on('reset', _.bind(->
      @trigger 'reload'
      @renderNotes()
      Notin.app.mason.layNotes()
    , this))
    @notes.fetch({data: {keywords: @keywords}})