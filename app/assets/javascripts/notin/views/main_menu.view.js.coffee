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
    Notin.app.showModal('help')