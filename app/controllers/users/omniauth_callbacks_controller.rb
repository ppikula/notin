class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :authenticate_user!

  def facebook
    @user = User.find_for_facebook_oauth(request.env['omniauth.auth'], current_user)

    sign_in @user

    redirect_to ''
  end
end