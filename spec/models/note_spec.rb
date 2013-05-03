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
      @note1 = Note.create(:content => 'apollo zeus', :tag_list => 'thor')
      @note2 = Note.create(:content => 'apollo', :tag_list => 'freya', :title => 'rogue knight')
      @note3 = Note.create(:content => '', :tag_list => 'loki, freya')
      @note4 = Note.create(:content => 'hera poseidon tyr', :tag_list => 'odin, thor', :title => 'rogue')
      @note5 = Note.create(:content => 'aphrodite', :tag_list => 'frey, tyr')
    end

    it 'finds notes by fragment of a word in a content' do
      Note.search('ap').collect{|n| n.id}.sort.should == [@note1.id, @note2.id, @note5.id].sort
    end

    it 'finds notes by title' do
      Note.search('rogue').collect{|n| n.id}.sort.should == [@note2.id, @note4.id].sort
    end

    it 'finds notes by two words in a content' do
      Note.search('apollo zeus').collect{|n| n.id}.sort.should == [@note1.id].sort
    end

    it 'finds notes by tag and a word' do
      Note.search('hera odin').collect{|n| n.id}.sort.should == [@note4.id].sort
    end

    it 'finds notes by tag and a fragment of word' do
      Note.search('ap fre').collect{|n| n.id}.sort.should == [@note2.id, @note5.id].sort
    end

    it 'doesn\'t find anything when there is no match' do
      Note.search('heroina').should == []
    end
  end
end
