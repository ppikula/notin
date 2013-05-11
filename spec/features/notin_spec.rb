# Encoding: UTF-8
require 'spec_helper'

describe 'clicking home link', :notes_feature => true, :login => true do
  before do
    visit '/s/zeus'
    click_link NotesConstants::HOME_TITLE
  end

  it 'redirects to home' do
    current_path.should == "/"
  end
end