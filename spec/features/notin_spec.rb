# Encoding: UTF-8
require 'spec_helper'

describe 'listing notes', :notes_feature => true do
  it 'focuses search input at first' do
    visit '/'
    page.evaluate_script("document.activeElement.id").should == NotesFeatures::SEARCH_INPUT_ID
  end
end