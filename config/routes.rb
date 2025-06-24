Rails.application.routes.draw do
  devise_for :users, controllers: { saml_sessions: 'saml_sessions' }

  devise_scope :user do
    get '/users/accepted', to: 'saml_sessions#accepted'
  end

  resources :requests, except: [:show]
  get 'requests/actual', to: 'requests#actual'
  patch 'requests/update_status/:id', to: 'requests#update_status'
  get 'requests/:id/statement', to: 'requests#statement_generate'
  get 'requests/:ids/bulk_statement', to: 'requests#bulk_statement_generate'

  resources :subjects, only: [:index, :update, :create]

  resources :subjects_teachers, except: [:show, :edit]

  resources :teachers, only: [:index]

  resources :templates

  resources :groups

  resources :reasons

  resources :users, only: [:index, :update]

  resources :notifications, only: [:index, :update]
  patch 'notifications/:id/read', to: 'notifications#read'
end
