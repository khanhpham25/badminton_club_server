Rails.application.routes.draw do
  namespace :api, defaults: { format: "json" } do
    devise_for :users, controllers: {sessions: "api/sessions"}

    resources :users, except: %i[new edit]
  end
end
