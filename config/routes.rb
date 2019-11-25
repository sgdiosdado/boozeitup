Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "events#index"

  # Index of the application (Home)
  get "events", to: "events#index"

  # Forms to create a new event
  get "events/new", to: "events#new", as: :event_new

  # View of the events created by the current user
  get "events/my_events", to: "events#my_events", as: :my_events

  # View of the events which the current user is attending
  get "events/my_asists", to: "events#my_asists", as: :my_asists

  # Popup menu to confirm the deletion of event
  get "events/:id/confirmation", to: "events#confirmation", as: :event_confirmation

  # Calls the API for the location details
  get "events/event_get_location_details/:locationid", to: 'events#event_get_location_details', constraints: { locationid: /[^\/]+/}, as: :event_get_location_details

  # Calls the API for the best five suggestions
  get "events/event_location_suggestions/:address", to: 'events#event_location_suggestions', constraints: { address: /[^\/]+/ }, as: :event_location_suggestions
  
  # View to show details of an specific event
  get "events/:id", to: "events#show"

  # Forms to edit details of an specific event
  get "events/:id/edit", to: "events#edit", as: :event_edit

  # Action to delete aan specific event
  delete "events/:id", to: "events#destroy"

  # Acction to update an specific event
  patch "events/:id", to: "events#update", as: :event

  # Action to create an specific event
  post "events", to: "events#create"

  # Action to create a new Attend model record
  post "events/:id", to: "events#create_attend", as: :create_attend

end
