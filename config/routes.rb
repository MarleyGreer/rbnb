Rails.application.routes.draw do
  devise_for :users
  root to: 'garments#index'
  resources :garments do
    collection do
      get :all
    end
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:show, :edit, :index, :destroy, :update] do
     collection do
      get :all
      get :confirmed
      get :cancelled
      get :pending
      get :declined
    end
      member do
        patch :confirm
        patch :decline
        patch :cancel
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
end
