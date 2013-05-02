# Encoding: UTF-8
require 'spec_helper'

describe 'destroying notes', :notes_feature => true do
  context 'when user accepts' do
    before do
      page.driver.accept_js_confirms!
      delete_note
    end

    it 'makes note not displaying on list' do
      displayed_notes.count.should == @notes.count - 1
    end
  end

  context 'when user dismisses' do
    before do
      page.driver.dismiss_js_confirms!
      delete_note
    end

    it 'makes note still displaying on list' do
      displayed_notes.count.should == @notes.count
    end
  end

  def delete_note
    @notes = Seeder::create_notes
    @note_to_delete = @notes.first

    visit '/'

    within note_element(@note_to_delete.id) do
      click_link NotesFeatures::DELETE_TITLE
    end

    wait_until_content_is_loading
  end
end