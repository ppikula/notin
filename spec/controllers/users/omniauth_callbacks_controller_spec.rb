require 'spec_helper'

describe Users::OmniauthCallbacksController do
  include FacebookAuthHelpers
  include Devise::TestHelpers

  describe 'facebook' do
    before do
      @user = FactoryGirl.create(:user)

      request.env['devise.mapping'] = Devise.mappings[:user]
      request.env['omniauth.auth'] = mock_omniauth(@user)
      
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
      @user = FactoryGirl.create(:user)

      request.env['devise.mapping'] = Devise.mappings[:user]
      request.env['omniauth.auth'] = mock_omniauth(@user)
      
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

