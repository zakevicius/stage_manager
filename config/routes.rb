# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'stages#index'

  resources :stages, only: %i[index show update] do
    resources :logs, only: :index
  end
end
