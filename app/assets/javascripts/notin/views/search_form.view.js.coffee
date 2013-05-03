Notin.SearchFormView = Backbone.View.extend
  events:
    'keyup #search': 'redirectToSearch'
    
  render: ->
    @$el.html JST['search_form']

    @$input = @$el.find '#search'

    this

  # @param [String] text
  setInputText: (text) ->
    @$input.val text

  redirectToSearch: (e) ->
    @blurOnEscape(e)

    # Redirect to search if keyword given, list otherwise.
    keywords = @$input.val()
    if keywords
      Notin.app.router.navigate('s/' + keywords, true)
    else if e.which != 83 # Don't list when shortcut was usedw
      Notin.app.router.listAllNotes()
    
  focusInput: ->
    @$input.focus()

  blurOnEscape: (e) ->
    if e.which == 27
      @$el.find('#search').blur()
      return false
