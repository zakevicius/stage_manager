#frozen_string_literal: true

Rails.application.routes.draw do
  resources :stages, only: %i[index show update] do
    resources :logs, only: :index
  end
end
