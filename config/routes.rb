Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    resources :feeds, only: [:index, :new, :create, :show] do
      delete 'remove', on: :member
    end
    resources :entries, only: [:index, :show] do
      get 'recent', on: :collection
    end
    resources :categories, only: [:index, :show, :destroy] 
  end

  root to: 'static_pages#root'

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :edit, :show, :update]

  resources :feeds, only: [:index, :new, :create, :show] do
    delete 'remove', on: :member
  end

  resources :entries, only: [:index, :show] do
    get 'recent', on: :collection
  end

  resources :categories
end
