Rails.application.routes.draw do
  get "communities/index"
  get "communities/show"
  devise_for :travelers
  get "pages/home"
  get "pages/about"
  get "pages/contact"
  get "travelers/index"
  get "travelers/show"
  get "travelers/new"
  get "travelers/create"
  get "travelers/edit"
  get "travelers/update"
  get "locations" => "locations#index", 
  controllers: {
  registrations: "travelers/registrations",
  sessions: "travelers/sessions",
  passwords: "travelers/passwords",
  confirmations: "travelers/confirmations",
  unlocks: "travelers/unlocks"
}

  resources :travelers, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :communities, only: [:index, :show]
  resources :locations, only: [:index, :show]


  authenticated :traveler do
    get 'dashboard', to: 'dashboards#show', as: :traveler_dashboard
  end

  root "pages#home"

end
