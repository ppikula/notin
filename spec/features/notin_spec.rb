# Encoding: UTF-8
require 'spec_helper'

describe 'clicking home link', :notes_feature => true do
  before do
    visit '/s/zeus'
    click_link NotesFeatures::HOME_TITLE
  end

  it 'redirects to home' do
    current_path.should == "/"
  end
end