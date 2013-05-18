require 'spec_helper'

describe Notin::Endpoints::Notes do
  # Stub Api helper current_user method.
  # @fixme: Can it be mocked with mocha?
  before :all do
    load 'patches/api_helpers.rb'
    @user = STUBBED_USER
  end

  # After tests, load regular helper method.
  after :all do
    load Rails.root.join('app/api/notin/api_helpers.rb')
  end

  describe 'GET /notes' do
    before do
      @notes = NotesSeeder::create(@user, skip_save: true)
    end

    it 'it renders all notes when no keyword is given' do
      User.any_instance.expects(:notes).returns(@notes)
      get '/notes'
      it_presents(@notes)
    end

    it 'it renders all notes when empty keywords string is given' do
      User.any_instance.expects(:notes).returns(@notes)
      get '/notes', {:keywords => ' '}
      it_presents(@notes)
    end

    it 'it renders specific @notes when keywords string is given' do
      specific_notes = @notes[0..1]
      Note.expects(:search).with(@user.id, 'zeus').returns specific_notes
      get '/notes', {:keywords => 'zeus'}

      it_presents(specific_notes)
    end
  end

  describe 'GET /notes/:id' do
    before do
      @note = FactoryGirl.build(:note, :id => 1, :content => 'Note', :tag_list => 'zeus, apollo')
      Note.expects(:for_user).with(@user, @note.id.to_s).returns @note
      Note.any_instance.expects(:user_tags).with(@user).returns(@note.tag_list.to_s)

      get "/notes/#{@note.id}"
    end

    it 'renders note' do
      it_presents(@note)
    end
  end

  describe 'POST /notes' do
    before do
      note_attribs = {:content => 'Note', :title => 'Title', :tag_list => 'zeus, apollo', :user_id => @user.id}
      @note = FactoryGirl.build(:note, note_attribs)
      Note.expects(:create).with(note_attribs.reject{|k| k == :tag_list}).returns @note
      Note.any_instance.expects(:user_tags).with(@user).returns(note_attribs[:tag_list])

      post '/notes', note_attribs
    end

    it 'renders created note' do
      it_presents(@note)
    end
  end

  describe 'PUT /notes/:id' do
    before do
      new_tags = 'zeus, apollo'
      new_note_attribs = {:content => 'Modified note', :title => 'New title'}
      @note = FactoryGirl.build(:note, :id => 1, :content => 'Note', :title => 'Title', :tag_list => nil)
      @updated_note = FactoryGirl.build(:note,
          :id => 1, :content => new_note_attribs[:content], :title => new_note_attribs[:title], :tag_list => new_tags
      )

      Note.expects(:for_user).with(@user, @note.id.to_s).returns @note
      Note.any_instance.stubs(:update_attributes).with(new_note_attribs)
      Note.any_instance.expects(:reload).returns @updated_note
      Note.any_instance.expects(:tag_by_user).with(@user, new_tags)
      Note.any_instance.expects(:user_tags).with(@user).returns(new_tags)

      put "/notes/#{@note.id}", new_note_attribs.merge({:tag_list => new_tags})
    end

    it 'renders updated note' do
      it_presents(@updated_note)
    end
  end

  describe 'DELETE destroy' do
    before do
      @note = FactoryGirl.build(:note, :id => 1)

      Note.expects(:for_user).with(@user, @note.id.to_s).returns @note
      Note.any_instance.expects(:destroy).returns @note
      Note.any_instance.expects(:user_tags).with(@user).returns(@note.tag_list.to_s)

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