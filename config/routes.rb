Rails.application.routes.draw do
  root to: 'static_pages#root'

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :edit, :show, :update]
  resources :feeds, only: [:index, :new, :create, :show]
  resources :entries, only: [:show]
end
