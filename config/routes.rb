Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }
  # devise_scope :user do
  #   delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  # end

  root 'challenges#index'

  # TODO
  get 'challenges/easy',   to: 'challenges#easy'
  get 'challenges/medium', to: 'challenges#medium'
  get 'challenges/hard',   to: 'challenges#hard'

  resources :challenges do
    resources :comments
  end

  resources :users, only: :show

  resources :tags
end
