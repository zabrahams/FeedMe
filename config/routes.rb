require 'resque/server'

Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    resources :feeds, only: [:index, :new, :create, :show] do
      post 'remove', on: :member
    end
    resources :entries, only: [:index] do
      get 'recent', on: :collection
      post 'read', on: :member
    end
    resources :categories, only: [:index, :show, :create, :update, :destroy]
    resources :users, only: [:index, :show, :create, :update] do
      get 'personal_feed', on: :member
      get 'activation', on: :member
      resource :followings, only: [:create, :destroy]
    end
    resource :session, only: [:show, :create, :destroy] do
      post 'username', on: :collection
    end

    resources :security_questions, only: :index
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

  mount Resque::Server.new, at: "/resque"
end
