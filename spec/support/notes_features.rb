module NotesFeatures
  # Global
  CREATE_NEW_NOTE_TITLE = 'Create new note'
  LOADER = '#loader'
  SEARCH_INPUT_ID = 'search'

  # Note element
  NOTE_SELECTOR = 'data-note-id'
  NOTE = '.note'

  # Note buttons
  DELETE_TITLE = 'Delete'
  EDIT_TITLE = 'Edit'
  EXPAND_TITLE = 'Expand'
  CLOSE_TITLE = 'Close'

  # Form
  CONTENT_LABEL = 'Content'
  TAGS_LABEL = 'Tags'
  TITLE_LABEL = 'Title'

  CONTENT_TEXTAREA = 'textarea#content'
  TAGS_INPUT = 'input#tag_list'
  TITLE_INPUT = 'input#title'

  SAVE_BUTTON = 'Save'
  CANCEL_BUTTON = 'Cancel'

  # @param [Integer] note_id
  # @return [String]
  def note_element(note_id)
    "[#{NOTE_SELECTOR}=\"#{note_id}\"]"
  end

  # @return [Array<Integer>]
  def displayed_notes_ids
    displayed_notes.collect { |node| node[NOTE_SELECTOR].to_i }.sort
  end

  # @return [Array<Capybara::Node::Element>]
  def displayed_notes
    page.all(NOTE)
  end

  # @param [Hash] attrs
  def fill_note_form(attrs)
    fill_in NotesFeatures::CONTENT_LABEL, :with => attrs[:content]
    fill_in NotesFeatures::TAGS_LABEL, :with => attrs[:tag_list]
    fill_in NotesFeatures::TITLE_LABEL, :with => attrs[:title]

    click_button(NotesFeatures::SAVE_BUTTON)
  end

  # Is loader visible?
  # @return [Boolean]
  def wait_until_content_is_loading
    wait_until { !page.find(NotesFeatures::LOADER).visible? }
  end
end