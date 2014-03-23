BasicAuthDemo::Application.routes.draw do
  resources :users

  get '/login',  to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
