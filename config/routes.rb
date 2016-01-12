Rails.application.routes.draw do
  devise_for :users
  root 'challenges#index'

  # REFACTOR
  get 'challenges/easy',   to: 'challenges#easy'
  get 'challenges/medium', to: 'challenges#medium'
  get 'challenges/hard',   to: 'challenges#hard'

  get 'users/authorize', to: 'users#authorize'
  get 'users/callback', to: 'users#callback'

  resources :challenges do
    resources :comments
  end

  resources :tags
end
