Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/users' => 'users#index'
  get '/users/:id' => 'users#show'
  get '/products' => 'products#index'
  get '/orders' => 'orders#index'
  get '/products/:id' => 'products#show'
  post '/products' => 'products#create'
  post '/products/:id' => 'products#update'

  get '/pages' => 'pages#index'
  get '/pages/:title' => 'pages#show'
  post '/pages' => 'pages#create'
  post '/pages/:title' => 'pages#update'
end
