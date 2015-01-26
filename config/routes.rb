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
    resource :session, only: [:show, :create, :destroy]

    resources :comments, only: [:index, :create, :update, :destroy]

    resources :security_questions, only: :index
  end

  root to: 'static_pages#root'

  mount Resque::Server.new, at: "/resque"
end
