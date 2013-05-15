key 'esc', 'closable', ->
  Notin.router.navigate('/', true)

key 'h', ->
  Notin.router.listAllNotes()

key 'n', ->
  Notin.router.navigate('/n', true)

key 's', (e) ->
  $(e.preventDefault())
  Notin.app.searchFormView.focusInput()