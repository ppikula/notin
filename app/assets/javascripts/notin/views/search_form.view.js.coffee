Notin.SearchFormView = Backbone.View.extend
  events:
    'keyup #search': 'redirectToSearch'
    
  render: ->
    @$el.html JST['search_form']

    @$input = @$el.find '#search'

    this
    
  redirectToSearch: ->
    keywords = @$input.val()

    # Redirect to search if keyword given, list otherwise.
    if keywords
      Notin.app.router.navigate('s/' + keywords, true)
    else
      Notin.app.router.listAllNotes()
    
  focusInput: ->
    @$input.focus()

  # @param [String] text
  setInputText: (text) ->
    @$input.val text
