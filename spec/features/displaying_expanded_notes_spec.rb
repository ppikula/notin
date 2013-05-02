require 'spec_helper'

describe 'displaying expanded notes', :notes_feature => true do
  before do
    @limit = 400
    @note = FactoryGirl.create(:note, :content => 'foo' * (@limit * 2))
    visit "/n/#{@note.id}"
  end

  it 'displays full-lenght note content' do
    within note_element(@note.id) do
      page.should have_text @note.content
    end
  end
end