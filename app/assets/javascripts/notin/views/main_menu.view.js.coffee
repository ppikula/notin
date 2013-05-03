Notin.MainMenuView = Backbone.View.extend
  events:
    'click #home': 'redirectToHome'
    'click #new_note': 'redirectToNewNote'

  render: ->
    @$el.html JST['main_menu']

    this

  redirectToHome: ->
    Notin.app.router.listAllNotes()

  redirectToNewNote: ->
    Notin.app.router.navigate('n', true)
