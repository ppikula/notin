Notin::Application.routes.draw do
  mount Notin::API => '/'

  # Redirect everything that doesn't match to boostrap.
  match '/*path' => 'notin#index'
  
  root :to => 'notin#index'
end
