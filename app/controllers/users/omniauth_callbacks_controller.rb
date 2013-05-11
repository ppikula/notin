class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :authenticate_user!

  def facebook
    sign_in User.find_or_create_facebook_user(request.env['omniauth.auth'])
    redirect_to ''
  end
end