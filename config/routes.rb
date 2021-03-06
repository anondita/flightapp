Rails.application.routes.draw do
  resources :airplanes
  get '/flights/:flight_id/seats/indexfirst',to: 'seats#indexfirst', as: 'firstseat'
  get '/flights/:flight_id/seats/indexeconomy',to: 'seats#indexeconomy', as: 'economyseat'
  get '/flights/:flight_id/seats/indexbusiness',to: 'seats#indexbusiness', as: 'businessseat'
  get '/flights/:flight_id/seats/createeco',to: 'seats#createeco'
  post '/flights/:flight_id/seats/createeco',to: 'seats#createeco',as:"createeco"
  get '/users/:user_id/bookings', to: 'bookings#index', as: 'bookings_index'
  post '/users/:user_id/flights/:flight_id/bookings', to: 'bookings#create', as: 'bookings'
  get '/users/:user_id/flights/:flight_id/bookings/new', to: 'bookings#new', as: 'new_booking'
  get '/users/:user_id/flights/:flight_id/bookings/:id/edit', to: 'bookings#edit', as: 'edit_booking'
  get '/users/:user_id/flights/:flight_id/bookings/:id', to: 'bookings#show', as: 'booking'
  patch '/users/:user_id/flights/:flight_id/bookings/:id', to: 'bookings#update'
  put '/users/:user_id/flights/:flight_id/bookings/:id', to: 'bookings#update'
  delete '/users/:user_id/flights/:flight_id/bookings/:id', to: 'bookings#destroy'

  get '/search_pnr', to: 'flights#search_pnr', as: 'search_pnr'
  get 'bookings/:booking_id/seatmap', to: 'flights#seatmap', as: 'seatmap'
  post '/bookings/:booking_id/seatmap', to: 'bookings#seatmap'
  post '/seatconfirm', to: 'bookings#seatconfirm' , as: 'seatconfirm'
  root to: 'flights#home'
  devise_for :users
  resources :flights do
  	resources :businesses
  	resources :economies
  	resources :firstclasses
  end

  get '/airplanes/:airplane_id/flights/new', to: 'airplanes#flightnew', as: 'airplane_flight'
  post '/airplanes/:airplane_id/flights/new', to: 'airplanes#flightcreate'
  get '/bookings/:booking_id/upgrade', to: 'bookings#upgrade', as: 'booking_upgrade'
  post '/bookings/:booking_id/upgrade', to: 'bookings#upgradecreate'
  get '/users/:user_id/flights/finder', to: 'flights#finder', as: 'flights_finder'
  post '/users/:user_id/flights/finder',to: 'flights#finderc'
  get '/flights/:id/seatconfig', to: 'flights#seatcon',as: 'seat'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
