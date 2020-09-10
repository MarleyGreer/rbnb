Rails.application.routes.draw do
  devise_for :users
  root to: 'garments#index'
  resources :garments do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:show, :edit, :index, :destroy, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
