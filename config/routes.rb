Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :car_categories, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :subsidiaries, only: [:index, :show, :new, :create, :edit, :update]
  resources :car_models, only: [:index, :show, :new, :create]
  resources :rentals, only: [:index, :show, :new, :create] do
    resources :car_rentals, only: [:new, :create]
    get 'search', on: :collection
  end
end
