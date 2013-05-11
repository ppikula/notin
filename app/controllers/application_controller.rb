class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  private

  # Redirect logged in user to page he tried to open.
  # @param [String] resource
  # @return [String] url
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end
end