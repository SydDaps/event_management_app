# frozen_string_literal: true

module Api
  module V1
    class TokensController < ApplicationController
      def create
        auth_fields = {
          email: params[:email],
          password: params[:password]
        }

        data = Auth::AuthenticateService.call(auth_fields)

        render(json: Api::Response.body(true, 200, data))
      end
    end
  end
end
