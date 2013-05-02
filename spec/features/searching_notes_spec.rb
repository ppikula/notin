# Encoding: UTF-8
require 'spec_helper'


# @param [String] keywords
# @param [Array<Integer>] expected_ids
def it_returns_only_matching_records(keywords, expected_ids)
  it "returns only matching records" do
    search keywords
    displayed_notes_ids.should == expected_ids.sort
  end
end

# Note: Searching testing is more detailed in Note model spec.
describe 'searching notes', :notes_feature => true do
  before do
    @notes = Seeder::create_notes
    visit '/'
  end

  context 'for keyword' do
    it_returns_only_matching_records('zeus', [1, 3, 5, 8, 12])
  end

  context 'for content fragment' do
    it_returns_only_matching_records('lambda', [11])
  end

  context 'for text that doesn\'t exist' do
    it_returns_only_matching_records('foobar', [])
  end

  describe 'by providing keyword' do
    before do
      @keyword = 'zeus'
      search @keyword
    end

    it 'redirects to search' do
      current_path.should == "/s/#{@keyword}"
    end

    it 'sets search input with given keyword' do
      find("##{NotesFeatures::SEARCH_INPUT_ID}").value.should == @keyword
    end
  end

  describe 'not providing keyword' do
    it 'redirects to list' do
      search ''
      current_path.should == '/'
    end
  end

  # @param [String] keywords
  def search(keywords)
    fill_in(NotesFeatures::SEARCH_INPUT_ID, :with => keywords)
    wait_until_content_is_loading
  end
end