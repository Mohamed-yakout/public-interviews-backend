# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts, controllers: {
      sessions: 'accounts/sessions'
  }


  # devise_for :accounts

  # devise_scope :account do
  #   post 'sign_in', controller: "/accounts/sessions", action: :create
  # end

  resources :transactions, only: [:index, :create, :show]

  # post 'sign_in', to: 'sessions#create', as: 'log_in'
  # delete 'logout', to: 'sessions#destroy'

  root 'transactions#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
