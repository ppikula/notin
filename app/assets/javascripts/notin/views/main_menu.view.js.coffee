Notin.MainMenuView = Backbone.View.extend
  events:
    'click #home': 'redirectToHome'
    'click #new_note': 'redirectToNewNote'

  render: ->
    @$el.html JST['main_menu'] { loggedIn: Notin.currentUserId != null }

    this

  redirectToHome: ->
    Notin.router.listAllNotes()

  redirectToNewNote: ->
    Notin.router.navigate('n', true)
