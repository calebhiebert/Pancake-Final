Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/users' => 'users#index'
  get '/users/:id' => 'users#show'
  get '/products' => 'products#index'
  get '/orders' => 'orders#index'
end
