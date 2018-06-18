Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  post '/rate' => 'rater#create', :as => 'rate'
  root 'static_pages#home'
  get '/search', to: 'static_pages#search'
  get'/new', to: 'static_pages#new'
  delete '/unfriend', to: 'relationships#unfriend'

  devise_for :users , controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: [:index, :show]
  resources :films do
    get :view, on: :member
    collection do
      get :filter
      get :top_movie
    end
    resources :comments
  end
  resources :relationships, only: [:index, :create, :update] do
    get :requesting_friends, :requested_friends, on: :collection
    delete :cancel_request_with, :delete_request_from, on: :member
  end
end
