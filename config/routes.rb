Rails.application.routes.draw do
  devise_for :travelers, controllers: {
    registrations: "travelers/registrations",
    sessions: "travelers/sessions",
    passwords: "travelers/passwords",
    confirmations: "travelers/confirmations",
    unlocks: "travelers/unlocks"
  }

  resources :travelers, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :communities, only: [:index, :show]
  resources :locations, only: [:index, :show]
  resources :saved_communities, only: [:create, :destroy]

  get "pages/home"
  get "pages/about"
  get "pages/contact"
  # get "search_communities", to: "communities#search", as: :search_communities
  post "search_communities", to: "communities#search", as: :search_communities

  authenticated :traveler do
    get 'dashboard', to: 'dashboards#show', as: :traveler_dashboard
  end

  root "pages#home"
end
