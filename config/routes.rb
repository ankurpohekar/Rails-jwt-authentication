Rails.application.routes.draw do
  resources :users
  namespace :account do
    post '/auth/login', to: 'authentication#login'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
