# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts, controllers: {
      sessions: 'accounts/sessions'
  }

  resources :transactions, only: [:index, :create, :show] do
    collection do
      get 'sent_transactions'
      get 'received_transactions'
    end
  end

  root 'transactions#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
