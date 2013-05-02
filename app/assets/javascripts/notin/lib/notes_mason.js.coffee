# Lays notes on page.
# http://masonry.desandro.com/
# Calculates their size and width to make it look best depending on screen width.
class Notin.NotesMason
  constructor: ->
    $(window).resize _.bind(->
      this.layNotes()
    , this)

  layNotes: ->
    $('.note').not('.standalone').css 'width', @calculateNoteWidth()
    $( '#notes').masonry itemSelector: '.note'

  calculateNoteWidth: ->
    noteWidth = $('#notes').width() / @resolveNotesPerRow()

    # For some reason, Masonry can't fit items for some resolutions, so it has to be 1px smaller @fixme
    noteWidth = noteWidth - 1
    noteWidth

  resolveNotesPerRow: ->
    if matchMedia('only screen and (max-width: 480px)').matches
      1
    else if matchMedia('only screen and (max-width: 768px)').matches
      2
    else if matchMedia('only screen and (max-width: 1400px)').matches
      3
    else
      4