Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    registrations: 'registrations' }

  root 'challenges#index'

  get 'user/:username',           to: 'users#show',       as: :user
  get 'user/:username/comments',  to: 'users#comments',   as: :user_comments
  get 'user/:username/submitted', to: 'users#submitted',  as: :user_submitted
  get 'user/:username/starred',   to: 'users#starred',    as: :user_starred
  get 'user/:username/completed', to: 'users#completed',  as: :user_completed

  get 'challenges/easy',   to: 'challenges#easy'
  get 'challenges/medium', to: 'challenges#medium'
  get 'challenges/hard',   to: 'challenges#hard'

  resources :challenges do
    resources :comments
  end

  get 'tag/:name', to: 'tags#show', as: :tag
  resources :tags, only: :index
end
