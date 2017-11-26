Rails.application.routes.draw do
  namespace :api, defaults: { format: "json" } do
    devise_for :users, skip: :registrations, controllers: {sessions: "api/sessions"}

    post 'auth/omniauths', to: 'omniauths#create'
    delete 'auth/omniauths', to: 'omniauths#destroy'

    resources :users, except: %i[new edit]
    resources :clubs, except: %i[new edit]
    resources :join_requests, except: %i[new edit]
    resources :password_resets, only: :create
    patch 'password_resets', to: 'password_resets#update'
  end
end
