Notin.Router = Backbone.Router.extend
  routes:
    '': 'listNotes'
    's/:keywords(/:first)': 'searchNotes'
    'sf/:keywords': 'showFirstMatchingNote'
    'n': 'newNote'
    'n/:id': 'showNote'
    'e/:id': 'editNote'

  listNotes: ->
    Notin.app.showNotes()
    key.setScope('all')

  searchNotes: (keywords) ->
    Notin.app.showNotes({keywords: keywords})
    Notin.app.searchFormView.setInputText(keywords)
    key.setScope('all')

  showFirstMatchingNote: (keywords) ->
    Notin.app.showFirstMatchingNote(keywords)
    key.setScope('closable')

  newNote: ->
    Notin.app.showNewNoteForm()
    key.setScope('closable')

  showNote: (id) ->
    Notin.app.showNote(id)
    key.setScope('closable')

  editNote: (id) ->
    Notin.app.showEditNoteForm(id)
    key.setScope('closable')

  listAllNotes: ->
    Notin.router.navigate('/')
    Notin.app.showNotes({showAll: true})
    Notin.app.searchFormView.setInputText('')
    key.setScope('all')
