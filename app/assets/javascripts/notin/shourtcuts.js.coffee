key.setTmpScope = (scope, source) ->
  key.source = source
  key.prevScope = key.getScope()
  key.setScope(scope)

key.removeTmpScope = ->
  key.setScope(key.prevScope)

key.filter = (event) ->
  # Disallow any shortcuts when modal is present.
  if $('#simplemodal-overlay').length > 0
    return false

  tagName = (event.target || event.srcElement).tagName
  !(tagName == 'INPUT' || tagName == 'SELECT' || tagName == 'TEXTAREA')

key 'esc', ->
  Notin.router.navigate('/', true)

key 'h', ->
  Notin.router.listAllNotes()

key 'n', ->
  Notin.router.navigate('/n', true)

key 'shift+/', ->
  Notin.app.showModal('help')

key 's', (e) ->
  $(e.preventDefault())
  Notin.app.searchFormView.focusInput()

key 'e', 'note', ->
  Notin.router.navigate('/e/' + key.source.data('note-id'), true)

key 'f', 'note', ->
  Notin.router.navigate('/n/' + key.source.data('note-id'), true)

key 'd', 'note', ->
  Notin.router.navigate('/d/' + key.source.data('note-id'), true)