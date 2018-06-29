Rails.application.routes.draw do

  root 'application#index'

  resources :messages, only: [:index, :create, :destroy]
end
