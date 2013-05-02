Notin.AppView = Backbone.View.extend
  processQueueSize: 0   # Number of pending AJAX requests.
  currentKeywords: null # Active keywords filter.
  initialize: ->
    @router = new Notin.Router
    @mason = new Notin.NotesMason

    @initializeLoader()

    @searchFormView = new Notin.SearchFormView
    @mainMenuView = new Notin.MainMenuView

  render: ->
    @$el.html(JST['app'])

    @$loader = @$el.find('#loader')
    @$pageContainer = @$el.find('#page_container')

    @renderSearchForm()
    @renderMainMenu()

    this

  # Show loader when any request is pending.
  # Hide, when all requests are complete.
  initializeLoader: ->
    @on 'request:start', ->
      @processQueueSize++
      @$loader.show()

    @on 'request:complete', ->
      @processQueueSize--
      if @processQueueSize == 0
        @$loader.hide()

  renderSearchForm: ->
    @$el.find('#search_form_container').html(@searchFormView.render().$el)

  renderMainMenu: ->
    @$el.find('#main_menu_container').html(@mainMenuView.render().$el)

  # @param [Array] options
  # @option options [String] keywords
  # @option options [Boolean] all
  showNotes: (options) ->
    notesView = new Notin.NotesView({keywords: @resolveKeywords(options)})
    notesView.on('reload', _.bind(->
      @$pageContainer.html(notesView.render().$el)
    , this))

  # @param [Integer] noteId
  showNote: (noteId) ->
    new Notin.Note(id: noteId).fetch
      success: _.bind(
        (note) ->
          noteView = new Notin.NoteView(model: note, isStandAlone: true)
          @$pageContainer.html(noteView.render().$el)
        , this)

  showNewNoteForm: ->
    formView = new Notin.NoteFormView()
    @$pageContainer.html(formView.render().$el)

  # @param [Integer] noteId
  showEditNoteForm: (noteId) ->
    new Notin.Note(id: noteId).fetch
      success: _.bind(
        (note) ->
          formView = new Notin.NoteFormView({model: note})
          @$pageContainer.html(formView.render().$el)
      , this)

  # @param [Array] options
  # @return [String]
  resolveKeywords: (options) ->
    options = options || {}

    keywords = null
    unless options.showAll
      keywords = options.keywords || @currentKeywords

    @currentKeywords = keywords

    keywords
