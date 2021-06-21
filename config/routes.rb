# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    registrations: 'users/registrations'
  }

  root 'static_pages#home'

  # Admin Routes
  scope 'admin' do
    get 'users_index',    to: 'admins#users_index',   as: :admin_users
    get 'users_show/:id',     to: 'admins#users_show',    as: :admin_user
    get 'things_index',   to: 'admins#things_index',  as: :admin_things
  end

  resources :things
end
