Rails.application.routes.draw do
  devise_for :users
  root 'challenges#index'

  resources :challenges
  resources :tags
end
