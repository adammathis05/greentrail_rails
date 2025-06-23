Rails.application.routes.draw do
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
  get "locations" => "locations#index"

  resources :travelers, only: [:new, :create, :show, :edit, :update, :destroy]

  resources :communities, only: [:index, :show]

  root "pages#home"

end
