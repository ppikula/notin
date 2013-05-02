Notin.Router = Backbone.Router.extend
  routes:
    '': 'listNotes'
    's/:keywords': 'searchNotes'
    'n': 'newNote'
    'n/:id': 'showNote'
    'e/:id': 'editNote'

  listNotes: ->
    Notin.app.showNotes()
    Notin.app.searchFormView.focusInput()

  searchNotes: (keywords) ->
    Notin.app.showNotes({keywords: keywords})
    Notin.app.searchFormView.setInputText(keywords)

  newNote: ->
    Notin.app.showNewNoteForm()

  showNote: (id) ->
    Notin.app.showNote(id)

  editNote: (id) ->
    Notin.app.showEditNoteForm(id)

  listAllNotes: ->
    Notin.app.router.navigate('')
    Notin.app.showNotes({showAll: true})
