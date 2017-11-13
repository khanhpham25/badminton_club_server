Rails.application.routes.draw do
  namespace :api, defaults: { format: "json" } do
    devise_for :users, skip: :registrations, controllers: {sessions: "api/sessions"}

    get 'auth/omniauths', to: 'omniauths#create'
    delete 'auth/omniauths', to: 'omniauths#destroy'

    resources :users, except: %i[new edit]
  end
end
