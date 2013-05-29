# Encoding: UTF-8
require 'spec_helper'


describe 'authentication', :notes_feature => true do

  context 'facebook authentication' do 
    it 'shows login page by default' do
      visit '/'

      page_should_have_login_link
    end

    describe 'logging in as first time user' do
      it 'logins user and shows him his notes list' do
        visit '/'
        login_user(:facebook)

        page.current_path.should == '/'
      end
    end

    describe 'logging in as returning user' do
      it 'logins user and shows him his notes list' do
        visit '/'
        login_user(:facebook, new_user: true)

        page.current_path.should == '/'
      end
    end

    describe 'logging in after trying to show specific page' do
      it 'logins user and redirects to desired page' do
        visit '/n'
        login_user(:facebook, new_user: true)

        page.current_path.should == '/n'
      end
    end

    describe 'logging out' do
      it 'logs out user' do
        visit '/'
        login_user(:facebook)

        click_link NotesConstants::LOGOUT_TITLE

        page_should_have_login_link
      end
    end

    def page_should_have_login_link
      page.should have_css "a[title='#{NotesConstants::FACEBOOK_LOGIN_TITLE}']"
    end
  end 


  context 'google oauth2 authentication' do 
    it 'shows login page by default' do
      visit '/'

      page_should_have_login_link
    end

    describe 'logging in as first time user' do
      it 'logins user and shows him his notes list' do
        visit '/'
        login_user(:google_oauth2)

        page.current_path.should == '/'
      end
    end

    describe 'logging in as returning user' do
      it 'logins user and shows him his notes list' do
        visit '/'
        login_user(:google_oauth2, new_user: true)

        page.current_path.should == '/'
      end
    end

    describe 'logging in after trying to show specific page' do
      it 'logins user and redirects to desired page' do
        visit '/n'
        login_user(:google_oauth2, new_user: true)

        page.current_path.should == '/n'
      end
    end

    describe 'logging out' do
      it 'logs out user' do
        visit '/'
        login_user(:google_oauth2)

        click_link NotesConstants::LOGOUT_TITLE

        page_should_have_login_link
      end
    end

    def page_should_have_login_link
      page.should have_css "a[title='#{NotesConstants::GOOGLE_LOGIN_TITLE}']"
    end
  end
end