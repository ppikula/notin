Notin.MainMenuView = Backbone.View.extend
  events:
    'click #home': 'redirectToHome'
    'click #new_note': 'redirectToNewNote'
    'click #help': 'showHelp'

  render: ->
    @$el.html JST['main_menu']

    this

  redirectToHome: ->
    Notin.router.listAllNotes()

  redirectToNewNote: ->
    Notin.router.navigate('n', true)

  showHelp: ->
    $help = $('<div></div>')
    $help.html(JST['help'])

    $.modal($help,
      # Don't allow any shortcuts.
      onShow: ->
        @prevScope = key.getScope()
        key.setScope('none')
      onClose: ->
        key.setScope(@prevScope)
        $.modal.close()
    )
