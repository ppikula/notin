key 'esc', 'closable', ->
  Notin.app.router.navigate('/', true)

key 'h', ->
  Notin.app.router.listAllNotes()

key 'n', ->
  Notin.app.router.navigate('/n', true)

key 's', (e) ->
  $(e.preventDefault())
  Notin.app.searchFormView.focusInput()

key.filter = (e) ->
  $el = $(e.target || e.srcElement)

  tagName = $el.prop('tagName')

  # Allow watching shortcuts on search input
  return true if $el.attr('id') == 'search'

  # Deny watching shortcuts on any other text inputs
  return false if (tagName == 'input' || tagName == 'input' || tagName == 'input')

  return true
