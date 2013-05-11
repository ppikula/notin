shared_examples_for 'a note form' do
  it 'has content textarea' do
    page.should have_css NotesConstants::CONTENT_TEXTAREA
  end

  it 'has tags input' do
    page.should have_css NotesConstants::TAGS_INPUT
  end

  it 'has title input' do
    page.should have_css NotesConstants::TITLE_INPUT
  end

  it 'has save button' do
    page.should have_button NotesConstants::SAVE_BUTTON
  end

  it 'has cancel button' do
    page.should have_button NotesConstants::CANCEL_BUTTON
  end

  it 'closes form and shows notes list when hitting cancel' do
    click_button NotesConstants::CANCEL_BUTTON
    wait_until_content_is_loading
    displayed_notes_ids.should == @notes.collect{|note| note.id}.sort
  end
end
