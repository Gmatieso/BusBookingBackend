Rails.application.routes.draw do
  resources :routes
  resources :bookings
  resources :buses
  # resources :clients
  # resources :drivers
  # resources :admins

  post '/admin-signup', to: 'admins#signup'    #Wen a request comes to the /admin-signup run the signup method in admins controller
  get '/admin-me', to: 'admins#show'
  post '/admin-login', to: 'admins#login'      
  delete '/admin-logout', to: 'admins#logout'

  post '/client-signup', to: 'clients#signup'   #wen a request comes to the /client-signup route  run the signup method in clients controller 
  get '/client-me', to: 'clients#show'
  post '/client-login', to: 'clients#login'
  delete '/client-logout', to: 'clients#logout'

  post '/driver-signup', to: 'drivers#signup'   #wen a request comes to the driver-signup route run the  signup method in  drivers controller 
  get '/driver-me', to: 'drivers#show'
  post '/driver-login', to: 'drivers#login'
  delete '/driver-logout', to: 'drivers#logout'
end
