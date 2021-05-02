#frozen_string_literal: true

Rails.application.routes.draw do
  resources :stages, only: %i[index show update] do
    resources :histories, only: :index
  end
end
