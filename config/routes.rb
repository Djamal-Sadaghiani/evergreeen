# frozen_string_literal: true

Rails.application.routes.draw do
  resources :events
  resources :companies
  resources :currencies
  resources :income_statements
  root to: 'pages#home'
  get 'pages/impressum'
  get 'pages/portfolio' => 'pages#portfolio'
  resources :trades
  resources :products
  devise_for :users

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
