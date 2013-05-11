# Encoding: UTF-8
require 'spec_helper'

describe 'listing notes', :notes_feature => true, :login => true do
  before do
    Seeder::create_notes
    visit '/'
    wait_until_content_is_loading
  end

  it 'displays all notes by default' do
    displayed_notes_ids.should == Note.all.collect{|note| note.id}.sort
  end

  # Note: window sizing seems to differ on various systems, so numbers are approximated.
  # @fixme: Is it possible to remove this approximation?
  describe 'adjusting notes per row count according to window size' do
    it 'shows 5 rows for page width ~ <= 1400px' do
      resize_window(1400 + 20)
      notes_per_row_count.should == 4
    end

    it 'shows 4 rows for page width ~ <= 1024px' do
      resize_window(1024 + 20)
      notes_per_row_count.should == 3
    end

    it 'shows 2 rows for page width ~ <= 768px' do
      resize_window(768 + 10)
      notes_per_row_count.should == 2
    end

    it 'shows 1 row for page width ~ <= 480px' do
      resize_window(480 + 10)
      notes_per_row_count.should == 1
    end

    # @return [Integer]
    def notes_per_row_count
      displayed_notes.select{|note_node| note_node["style"] =~ /top: 0px/}.count
    end

    # @param [Integer] width
    def resize_window(width)
      page.driver.resize_window(width, 1000)
    end
  end
end