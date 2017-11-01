Rails.application.routes.draw do
  namespace :api, defaults: { format: "json" } do
    resources :users, except: %i[new edit]
    resources :sessions, only: %i[create destroy]
  end
end
