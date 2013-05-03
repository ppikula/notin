Notin::Application.routes.draw do
  mount Notin::API => '/'

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }

  # Redirect everything that doesn't match to boostrap.
  match '/*path' => 'notin#index'
  
  root :to => 'notin#index'
end
