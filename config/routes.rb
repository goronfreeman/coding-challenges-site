Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations, :passwords],
    controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks',
      registrations: 'registrations'
    }

  root 'challenges#index'

  # Default Devise routes
  #
  # Sessions
  # new_user_session     GET    /users/sign_in(.:format)  devise/sessions#new
  # user_session         POST   /users/sign_in(.:format)  devise/sessions#create
  # destroy_user_session DELETE /users/sign_out(.:format) devise/sessions#destroy
  #
  # Registrations
  # cancel_user_registration GET    /users/cancel(.:format)  registrations#cancel
  # user_registration        POST   /users(.:format)         registrations#create
  # new_user_registration    GET    /users/sign_up(.:format) registrations#new
  # edit_user_registration   GET    /users/edit(.:format)    registrations#edit
  #                          PATCH  /users(.:format)         registrations#update
  #                          PUT    /users(.:format)         registrations#update
  #                          DELETE /users(.:format)         registrations#destroy
  #
  # Passwords
  # user_password      POST  /users/password(.:format)      devise/passwords#create
  # new_user_password  GET   /users/password/new(.:format)  devise/passwords#new
  # edit_user_password GET   /users/password/edit(.:format) devise/passwords#edit
  #                    PATCH /users/password(.:format)      devise/passwords#update
  #                    PUT   /users/password(.:format)      devise/passwords#update

  devise_scope :user do
    # Sessions
    get    'login',  to: 'devise/sessions#new',     as: :new_user_session
    post   'login',  to: 'devise/sessions#create',  as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session

    # Registrations
    get    'signup',           to: 'registrations#new',    as: :new_user_registration
    post   'settings/account', to: 'registrations#create', as: :user_registration
    get    'settings/account', to: 'registrations#edit',   as: :edit_user_registration
    put    'settings/account', to: 'registrations#update'
    delete 'settings/account', to: 'registrations#destroy'

    # Passwords
    post 'settings/password',      to: 'devise/passwords#create', as: :user_password
    get  'settings/password/new',  to: 'devise/passwords#new',    as: :new_user_password
    get  'settings/password/edit', to: 'devise/passwords#edit',   as: :edit_user_password
    put  'settings/password',      to: 'devise/passwords#update'
  end

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
