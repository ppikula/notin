require 'spec_helper'

describe 'displaying help', :notes_feature => true, :login => true do
  before do
    click_link NotesConstants::HELP_TITLE
  end

  it 'shows help' do
    page.should have_css('#help')
  end
end