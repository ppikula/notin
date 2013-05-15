require 'spec_helper'

describe Note do
  it 'orders notes by updated_at DESC' do
    note1 = Note.new ; Timecop.freeze(15.minutes.ago) { note1.update_attribute(:title, nil) }
    note2 = Note.new ; Timecop.freeze(45.minutes.ago) { note2.update_attribute(:title, nil) }
    note3 = Note.new ; Timecop.freeze(10.minutes.ago) { note3.update_attribute(:title, nil) }

    Note.all.collect{|n| n.id}.should == [note3.id, note1.id, note2.id]
  end

  describe 'searching' do
    before do
      @user = FactoryGirl.create(:user)

      notes_attrs = [
          {:content => 'apollo zeus', :tag_list => 'thor'},
          {:content => 'apollo', :tag_list => 'freya', :title => 'rogue knight'},
          {:content => '', :tag_list => 'loki, freya'},
          {:content => 'hera poseidon tyr', :tag_list => 'odin, thor', :title => 'rogue'},
          {:content => 'aphrodite', :tag_list => 'frey, tyr'},
          {:content => 'hera poseidon tyr', :tag_list => 'odin, thor', :title => 'rogue', :user_id => 5}
      ]
      @notes = []
      notes_attrs.each do |attrs|
        note = Note.create(:content => attrs[:content], :title => attrs[:title])
        note.update_attribute(:user_id, attrs[:user_id] || @user.id)
        note.tag_by_user(@user, attrs[:tag_list])
        @notes << note
      end
    end

    it 'finds notes by fragment of a word in a content' do
      Note.search(@user.id, 'ap').collect{|n| n.id}.sort.should == [@notes[0].id, @notes[1].id, @notes[4].id].sort
    end

    it 'finds notes by title' do
      Note.search(@user.id, 'rogue').collect{|n| n.id}.sort.should == [@notes[1].id, @notes[3].id].sort
    end

    it 'finds notes by two words in a content' do
      Note.search(@user.id, 'apollo zeus').collect{|n| n.id}.sort.should == [@notes[0].id].sort
    end

    it 'finds notes by tag and a word' do
      Note.search(@user.id, 'hera odin').collect{|n| n.id}.sort.should == [@notes[3].id].sort
    end

    it 'finds notes by tag and a fragment of word' do
      Note.search(@user.id, 'ap fre').collect{|n| n.id}.sort.should == [@notes[1].id, @notes[4].id].sort
    end

    it 'doesn\'t find anything when there is no match' do
      Note.search(@user.id, 'heroina').should == []
    end

    it 'returns only users tags' do
      Note.search(@user.id, '').count.should == 5
    end
  end

  describe 'finding for user' do
    before do
      initialize_notes
    end

    it 'returns note' do
      Note.for_user(@user, @note.id).id.should == @note.id
    end

    it 'doesnt return invalid note' do
      Note.for_user(FactoryGirl.create(:user, :email => 'trillian@example.com'), @note.id).should == nil
    end
  end

  describe 'getting user tags' do
    before do
      initialize_notes
    end

    it 'returns tags' do
      @note.user_tags(@user).should == @tags
    end
  end

  describe 'tagging by user' do
    before do
      initialize_notes
    end

    it 'adds new tags' do
      new_tags = 'athena, poseidon'
      @note.tag_by_user(@user, new_tags)
      @note.reload.user_tags(@user).should == new_tags
    end
  end

  def initialize_notes
    @tags = 'apollo, hera'
    @user = FactoryGirl.create(:user)
    @note = FactoryGirl.create(:note)
    @note.update_attribute(:user_id, @user.id)

    @note.tag_by_user(@user, @tags)
  end
end
