# Encoding: UTF-8
require 'spec_helper'

describe 'editing notes', :notes_feature => true, :login => true do
  before do
    initialize_notes
    @note = @notes.first
    @new_note_attrs = {:content => "test\n\ntest", :title => 'Zeus', :tag_list => 'newton, einstein', :updated_at => Time.zone.now}
    visit '/'
  end

  describe 'form' do
    before do
      within note_element(@note.id) do
        click_link NotesConstants::EDIT_TITLE
      end
    end

    it_behaves_like 'a note form'
  end

  describe 'filling form' do
    before do
      within note_element(@note.id) do
        click_link NotesConstants::EDIT_TITLE
      end

      Timecop.travel(@new_note_attrs[:updated_at]) do
        fill_note_form(@new_note_attrs)
        wait_until_content_is_loading
      end
    end

    it 'updates note with given attributes' do
      @note.reload
      @note.content.should == @new_note_attrs[:content]
      @note.title.should == @new_note_attrs[:title]
      @note.user_tags(current_user).to_s.should == @new_note_attrs[:tag_list]
      @note.updated_at.to_s.should == @new_note_attrs[:updated_at].to_s
    end

    it 'refreshes note display' do
      within note_element(@note.id) do
        page.should have_text(@new_note_attrs[:content])
      end
    end
  end
end