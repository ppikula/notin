# Encoding: UTF-8
require 'spec_helper'

describe 'authentication', :notes_feature => true do
  it 'shows login page by default' do
    visit '/'

    page_should_have_login_link
  end

  describe 'clicking link as first time user' do
    it 'logins user and shows him his notes list' do
      initialize_notes
      visit '/'
      login_user

      displayed_notes_ids.should == @notes.collect{|n| n.id}.sort
    end
  end

  # @todo
  describe 'clicking link as returning user' do
    it 'logins user and shows him his notes list' do
      initialize_notes
      visit '/'
      login_user(new_user: true)

      displayed_notes_ids.should == @notes.collect{|n| n.id}.sort
    end
  end

  describe 'clicking logging out button' do
    it 'logs out user' do
      visit '/'
      login_user

      click_link NotesConstants::LOGOUT_TITLE

      page_should_have_login_link
    end
  end

  def page_should_have_login_link
    page.should have_css "a[title='#{NotesConstants::LOGIN_TITLE}']"
  end
end