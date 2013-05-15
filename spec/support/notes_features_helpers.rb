module NotesFeaturesHelpers
  # @param [Integer] note_id
  # @return [String]
  def note_element(note_id)
    "[#{NotesConstants::NOTE_SELECTOR}=\"#{note_id}\"]"
  end

  # @return [Array<Integer>]
  def displayed_notes_ids
    displayed_notes.collect { |node| node[NotesConstants::NOTE_SELECTOR].to_i }.sort
  end

  # @return [Array<Capybara::Node::Element>]
  def displayed_notes
    page.all(NotesConstants::NOTE)
  end

  # @param [Hash] attrs
  def fill_note_form(attrs)
    fill_in NotesConstants::CONTENT_LABEL, :with => attrs[:content]
    fill_in NotesConstants::TAGS_LABEL, :with => attrs[:tag_list]
    fill_in NotesConstants::TITLE_LABEL, :with => attrs[:title]

    click_button(NotesConstants::SAVE_BUTTON)
  end

  # Is loader visible?
  # @return [Boolean]
  def wait_until_content_is_loading
    wait_until { !page.find(NotesConstants::LOADER).visible? }
  end

  def initialize_notes
    @notes = NotesSeeder::create(current_user)
  end
end