# Encoding: UTF-8
require 'spec_helper'

shared_examples_for 'note is expanded' do
  it 'displays only given note' do
    displayed_notes_ids.should == [@note.id]
  end
end

shared_examples_for 'note is not expanded' do
  it 'displays all notes' do
    displayed_notes_ids.count.should == @notes.count
  end
end

describe 'expanding notes', :notes_feature => true, :login => true do
  before do
    initialize_notes
    @note = @notes.first
    visit '/'
  end

  describe 'clicking expand button' do
    before do
      click_expand_button(@note)
      wait_until_content_is_loading
    end

    include_examples 'note is expanded'

    it 'redirects to note page' do
      page.current_path.should == "/n/#{@note.id}"
    end
  end

  describe 'double clicking' do
    context 'on a note' do
      before do
        double_click(note_element(@note.id))
        wait_until_content_is_loading
      end

      include_examples 'note is expanded'
    end

    describe 'on note content' do
      before do
        double_click("#{note_element(@note.id)} .content")
        wait_until_content_is_loading
      end

      include_examples 'note is not expanded'
    end

    describe 'on note creation time' do
      before do
        double_click("#{note_element(@note.id)} .created_at")
        wait_until_content_is_loading
      end

      include_examples 'note is not expanded'
    end

    describe 'on note tags' do
      before do
        double_click("#{note_element(@note.id)} .tag_list")
        wait_until_content_is_loading
      end

      include_examples 'note is not expanded'
    end
  end

  describe 'shrinking note' do
    before do
      click_expand_button(@note)
    end

    context 'clicking "shrink" button again' do
      before do
        within note_element(@note.id) do
          click_link NotesConstants::CLOSE_TITLE
        end
        wait_until_content_is_loading
      end

      include_examples 'note is not expanded'
    end
  end

  # @param [Note] note
  def click_expand_button(note)
    within note_element(note.id) do
      click_link NotesConstants::EXPAND_TITLE
    end
    wait_until_content_is_loading
  end
end