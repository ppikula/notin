Notin.SearchFormView = Backbone.View.extend
  events:
    'keyup #search': 'search'
    'submit': 'preventSubmit'
    
  render: ->
    @$el.html JST['search_form']

    @$input = @$el.find '#search'

    this

  # @param [String] text
  setInputText: (text) ->
    @$input.val text

  focusInput: ->
    @$input.focus()

  search: (e) ->
    if e.which == 27 # Escape
      @$el.find('#search').blur()
    else if @$input.val()
      if e.which == 13 # Enter
        Notin.router.navigate('sf/' + @$input.val(), true)
      else
        Notin.router.navigate('s/' + @$input.val(), true)
    else if e.which != 83 # Don't list when shortcut was used
      Notin.router.listAllNotes()

    false

  preventSubmit: (e) ->
    e.preventDefault()