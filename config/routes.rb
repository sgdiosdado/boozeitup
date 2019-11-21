Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "events#index"

  get "events", to: "events#index"
  get "events/new", to: "events#new", as: :event_new
  get "events/my_events", to: "events#my_events", as: :my_events
  get "events/my_asists", to: "events#my_asists", as: :my_asists
  get "events/:id/confirmation", to: "events#confirmation", as: :event_confirmation
  get "events/:id", to: "events#show"
  get "events/:id/edit", to: "events#edit", as: :event_edit
  delete "events/:id", to: "events#destroy"

  patch "events/:id", to: "events#update", as: :event
  post "events", to: "events#create"
end
