Rails.application.routes.draw do
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
