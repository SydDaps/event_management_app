# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :token, only: [:create]

      resources :users, only: [:create, :show]
    end
  end
end
