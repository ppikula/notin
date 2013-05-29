require 'spec_helper'

describe Users::OmniauthCallbacksController do
  include AuthHelpers
  include Devise::TestHelpers

  describe 'facebook' do
    before do
      @user = FactoryGirl.create(:user)

      request.env['devise.mapping'] = Devise.mappings[:user]
      request.env['omniauth.auth'] = mock_omniauth(@user,:facebook)
      
      get :facebook
    end

    it 'logins user' do
      current_user.id.should == @user.id
    end

    it 'redirects to homepage' do
      response.should redirect_to '/'
    end
  end

  describe 'google' do 
    before do 
      @user = FactoryGirl.create(:user, provider: 'google_oauth2')

      request.env['devise.mapping'] = Devise.mappings[:user]
      request.env['omniauth.auth'] = mock_omniauth(@user,:google_oauth2)
      
      get :google_oauth2

    end 

    it 'logins user' do 
      current_user.id.should == @user.id
    end 

    it 'redirects to homepage' do 
      response.should redirect_to '/'
    end 

  end 
end

