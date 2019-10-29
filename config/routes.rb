Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "events#index"

  get "events", to: "events#index"
  get "events/new", to: "events#new", as: :event_new
  get "events/:id", to: "events#show"
  get "events/:id/edit", to: "events#edit", as: :event_edit
  get "events/:id/confirmation", to: "events#confirmation"

  patch "events/:id", to: "events#update", as: :event
  post "events", to: "events#create"

  delete "events/:id", to: "events#destroy"
end
