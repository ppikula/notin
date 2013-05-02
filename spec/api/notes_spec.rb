require 'spec_helper'

describe Notin::Endpoints::Notes do
  describe 'GET /notes' do
    before do
      @notes = [
          FactoryGirl.create(:note),
          FactoryGirl.create(:note),
          FactoryGirl.create(:note)
      ]
    end

    it 'it renders all notes when no keyword is given' do
      Note.expects(:all).returns(@notes)
      get '/notes'
      it_presents(@notes)
    end

    it 'it renders all notes when empty keywords string is given' do
      Note.expects(:all).returns(@notes)
      get '/notes', {:keywords => ' '}
      it_presents(@notes)
    end

    it 'it renders specific @notes when keywords string is given' do
      specific_notes = @notes[0..1]
      Note.stubs(:search).with('zeus').returns specific_notes
      get '/notes', {:keywords => 'zeus'}

      it_presents(specific_notes)
    end
  end

  describe 'GET /notes/:id' do
    before do
      @note = FactoryGirl.create(:note, :content => 'Note', :tag_list => 'apollo, athena')

      Note.expects(:find).with(@note.id.to_s).returns @note

      get "/notes/#{@note.id}"
    end

    it 'renders updated note' do
      it_presents(@note)
    end
  end

  describe 'POST /notes' do
    before do
      note_attribs = {:content => 'Note', :title => 'Title', :tag_list => 'apollo, athena'}
      @note = FactoryGirl.create(:note, note_attribs)
      Note.expects(:create).with(note_attribs).returns @note

      post '/notes', note_attribs
    end

    it 'renders created note' do
      it_presents(@note)
    end
  end

  describe 'PUT /notes/:id' do
    before do
      new_note_attribs = {:content => 'Modified note', :title => 'New title', :tag_list => 'zeus, athena'}
      @note = FactoryGirl.create(:note, :content => 'Note', :title => 'Title', :tag_list => 'apollo, athena')

      Note.expects(:find).with(@note.id.to_s).returns @note
      @note.update_attributes(new_note_attribs)
      @note.expects(:update_attributes).with(new_note_attribs).returns @note

      put "/notes/#{@note.id}", new_note_attribs
    end

    it 'renders updated note' do
      it_presents(@note)
    end
  end

  describe 'DELETE destroy' do
    before do
      @note = FactoryGirl.create(:note)

      Note.expects(:destroy).with(@note.id.to_s).returns @note

      delete "/notes/#{@note.id}"
    end

    it 'renders destroyed note' do
      it_presents(@note)
    end
  end

  # @params [Array<Note>|Note] expected
  def it_presents(expected)
    results = JSON.parse(response.body)
    results = results.is_a?(Array) ? results : [results]
    results = results.collect do |r|
      [r['id'], r['title'], r['content'], r['tag_list'], r['created_at'], r['updated_at']]
    end

    expected = expected.is_a?(Array) ? expected : [expected]
    expected = expected.collect do |r|
      [r.id, r['title'], r.content, r.tag_list.to_s, r.created_at.as_json, r.updated_at.as_json]
    end

    results.should == expected
  end
end