# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    registrations: 'users/registrations'
  }

  root 'static_pages#home'

  # Admin Routes
  scope 'admin' do
    get   'users_index',        to: 'admins#users_index',   as: :admin_users
    get   'users_show/:id',     to: 'admins#users_show',    as: :admin_user
    get   'things_index',       to: 'admins#things_index',  as: :admin_things
    post  'ban_user/:id',       to: 'admins#ban_user',      as: :ban_user
    post  'unban_user/:id',     to: 'admins#unban_user',    as: :unban_user
  end

  resources :things
end
