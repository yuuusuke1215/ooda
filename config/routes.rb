Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'oodaposts#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create, :destroy, :edit, :update] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end
  
  resources :oodaposts, only: [:show, :new, :create, :destroy, :edit, :update, :index] do
    resources :comments
    collection do
      get :search
    end 
  end
      
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :notifications, only: [:index]
end
