Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "events#index"
  
  get "events", to: "events#index"
  get "events/new", to: "events#new", as: :event_new
  get "events/my_events", to: "events#my_events", as: :my_events
  get "events/my_asists", to: "events#my_asists", as: :my_asists
  get "events/event_get_location_details/:locationid", to: 'events#event_get_location_details', as: :event_get_location_details
  get "events/event_location_suggestions/:address", to: 'events#event_location_suggestions', as: :event_location_suggestions
  get "events/:id", to: "events#show"
  get "events/:id/edit", to: "events#edit", as: :event_edit
  
  patch "events/:id", to: "events#update", as: :event
  post "events", to: "events#create"
  post "events/:id", to: "events#create_attend", as: :create_attend

end
