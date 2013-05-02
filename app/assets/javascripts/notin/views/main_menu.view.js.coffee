Notin.MainMenuView = Backbone.View.extend
  events:
    'click #new_note': 'redirectToNewNote'

  render: ->
    @$el.html JST['main_menu']

    this

  redirectToNewNote: ->
    Notin.app.router.navigate('n', true)
