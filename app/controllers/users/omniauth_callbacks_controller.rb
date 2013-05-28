class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :authenticate_user!

  def facebook
    sign_in_and_redirect User.find_or_create_facebook_user(request.env['omniauth.auth'])
  end

  def google_oauth2
  	sign_in_and_redirect User.find_or_create_google_user(request.env['omniauth.auth'])
  end

end