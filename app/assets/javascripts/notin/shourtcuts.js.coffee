key 'esc', 'closable', ->
  console.log 3
  Notin.router.navigate('/', true)

key 'h', ->
  Notin.router.listAllNotes()

key 'n', ->
  Notin.router.navigate('/n', true)

key 's', (e) ->
  $(e.preventDefault())
  Notin.app.searchFormView.focusInput()