# Encoding: UTF-8
require 'spec_helper'

describe 'authentication', :notes_feature => true do
  it 'shows login page by default' do
    visit '/'

    page_should_have_login_link
  end

  describe 'logging in as first time user' do
    it 'logins user and shows him his notes list' do
      visit '/'
      login_user

      page.current_path.should == '/'
    end
  end

  describe 'logging in as returning user' do
    it 'logins user and shows him his notes list' do
      visit '/'
      login_user(new_user: true)

      page.current_path.should == '/'
    end
  end

  describe 'logging in after trying to show specific page' do
    it 'logins user and redirects to desired page' do
      visit '/n'
      login_user(new_user: true)

      page.current_path.should == '/n'
    end
  end

  describe 'logging out' do
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