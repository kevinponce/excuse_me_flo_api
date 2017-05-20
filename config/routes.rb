Rails.application.routes.draw do
  resources :user_auth, only: [:create, :update]
  resources :users, only: [:create]
  resources :flow_charts, except: [:edit]
end
