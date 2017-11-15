Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Users
  get '/users' => 'users#index'
  get '/users/:id' => 'users#show'
  get '/me' => 'users#me'
  post '/register' => 'auth#register'
  post '/login' => 'auth#login'
  post '/logout' => 'auth#logout'

  # Products
  get '/products' => 'products#index'
  get '/products/search' => 'products#search'
  get '/products/categories' => 'products#categories'
  get '/products/:id' => 'products#show'
  post '/products' => 'products#create'
  post '/products/:id' => 'products#update'
  delete '/products/:id' => 'products#delete'

  # Images
  get '/images/:ident' => 'images#get'
  get '/images/:ident/:width' => 'images#get_sized'
  get '/images/:ident/:width/:height' => 'images#get_sized'
  post '/images/:productid' => 'images#upload'
  delete '/images/:ident' => 'images#delete'

  # Provinces
  get '/provinces' => 'provinces#index'
  get '/provinces/:id' => 'provinces#show'
  post '/provinces' => 'provinces#create'
  post '/provinces/:id' => 'provinces#update'
  delete '/provinces/:id' => 'provinces#delete'

  # Orders
  get '/orders' => 'orders#index'
  get '/orders/:orderid' => 'orders#show'
  post '/orders' => 'orders#create'

  # Pages
  get '/pages' => 'pages#index'
  get '/pages/:title' => 'pages#show'
  post '/pages' => 'pages#create'
  post '/pages/:title' => 'pages#update'
  delete '/pages/:title' => 'pages#delete'

  # Cart
  post '/cart/add' => 'cart#add_to_cart'
  post '/cart/clear' => 'cart#clear'
  post '/cart/remove' => 'cart#remove'
  get '/cart' => 'cart#get'

  # Billing
  post '/billme' => 'billing#make_payment'
end
