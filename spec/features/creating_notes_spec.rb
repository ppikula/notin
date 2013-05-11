# Encoding: UTF-8
require 'spec_helper'

describe 'creating notes', :notes_feature => true, :login => true do
  before do
    initialize_notes
    visit '/'
  end

  describe 'form' do
    before do
      click_link NotesConstants::CREATE_NEW_NOTE_TITLE
    end

    include_examples 'a note form'
  end

  describe 'filling form' do
    before do
      @new_note_attrs = {:content => "test\n\ntest", :title => 'Zeus', :tag_list => 'newton, einstein', :created_at => Time.zone.now}

      Timecop.freeze(@new_note_attrs[:created_at]) do
        visit '/'

        click_link NotesConstants::CREATE_NEW_NOTE_TITLE

        fill_note_form(@new_note_attrs)

        wait_until_content_is_loading
      end
    end

    it 'makes new note display on the list' do
      visit '/'
      displayed_notes_ids.should == (1..new_note_id).to_a
    end

    it 'creates new note with given attributes' do
      note = Note.find(new_note_id)
      note.content.should == @new_note_attrs[:content]
      note.title.should == @new_note_attrs[:title]
      note.tag_list.to_s.should == @new_note_attrs[:tag_list]
      note.created_at.to_s.should == @new_note_attrs[:created_at].to_s
    end

    it 'redirects to note page' do
      page.current_path.should == "/n/#{new_note_id}"
    end

    # @return [Integer]
    def new_note_id
      @notes.count + 1
    end
  end

  describe 'clicking new note link' do
    before do
      visit '/'
      click_link NotesConstants::CREATE_NEW_NOTE_TITLE
    end

    it 'redirects' do
      current_path.should == "/n"
    end
  end
end