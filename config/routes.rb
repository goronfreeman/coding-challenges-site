Rails.application.routes.draw do
  devise_for :users
  root 'challenges#index'

  # REFACTOR
  get 'challenges/easy',   to: 'challenges#easy'
  get 'challenges/medium', to: 'challenges#medium'
  get 'challenges/hard',   to: 'challenges#hard'

  resources :challenges
  resources :tags
end
