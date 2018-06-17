Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  post '/rate' => 'rater#create', :as => 'rate'
  root 'static_pages#home'
  get '/search', to: 'static_pages#search'
  get'/new', to: 'static_pages#new'

  devise_for :users , controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: [:index, :show]
  resources :relationships do
    get :requesting_friends, :requested_friends, on: :collection
    patch :accept_friend_with, on: :member
    delete :cancel_request_with, :delete_request_from, on: :member
  end

  post '/request_friend_with' => 'relationships#request_friend_with'

  resources :films do
    get :view, on: :member
    collection do
      get :filter
      get :top_movie
    end
    resources :comments
  end
end
