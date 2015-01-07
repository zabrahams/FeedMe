Rails.application.routes.draw do
  root to: 'users#new'

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :edit, :show, :update]
end
