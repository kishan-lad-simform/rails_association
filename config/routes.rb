Rails.application.routes.draw do

  get '/login', to: "users#check_login"
  post '/login', to: "users#login"
  get '/logout', to: "users#logout"
  get '/profile', to: "users#profile"
  get '/enroll/:id', to: "events#enroll", as: "enroll"
  post 'events/filter', to: "events#event_filter"
  get '/all_events', to: "events#all_events"
  get '/comment/:id', to: "comments#add_comment", as: "comment"
  post '/comment/:id', to: "comments#create_comment"
  get '/like/:id', to: "comments#like_comment", as: "like"
  get '/show/like', to: "comments#show_like", as: "show_like"
  get '/dislike/:id', to: "comments#dislike_comment", as: "dislike"
  root "events#index"
  resources :users
  resources :events

end
