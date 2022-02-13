# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :token, only: %i[create]

      resources :users, only: %i[create show]
    end
  end
end
