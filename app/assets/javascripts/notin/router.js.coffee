Notin.Router = Backbone.Router.extend
  routes:
    '': 'listNotes'
    's/:keywords(/:first)': 'searchNotes'
    'sf/:keywords': 'showFirstMatchingNote'
    'n': 'newNote'
    'n/:id': 'showNote'
    'e/:id': 'editNote'
    'd/:id': 'destroyNote'

  listNotes: ->
    Notin.app.showNotes()
    key.setScope('default')

  searchNotes: (keywords) ->
    Notin.app.showNotes({keywords: keywords})
    Notin.app.searchFormView.setInputText(keywords)
    key.setScope('default')

  showFirstMatchingNote: (keywords) ->
    Notin.app.showFirstMatchingNote(keywords)
    key.setScope('default')

  newNote: ->
    Notin.app.showNewNoteForm()
    key.setScope('default')

  showNote: (id) ->
    Notin.app.showNote(id)
    key.setScope('default')

  editNote: (id) ->
    Notin.app.showEditNoteForm(id)
    key.setScope('default')

  destroyNote: (id) ->
    return unless confirm('Are you sure you want to delete this note?')
    note = new Notin.Note(id: id)
    note.destroy(
      success: ->
        Notin.router.listAllNotes()
    )

  listAllNotes: ->
    Notin.router.navigate('/')
    Notin.app.showNotes({showAll: true})
    Notin.app.searchFormView.setInputText('')
    key.setScope('default')
