# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def create
        data = Users::CreateService.call(params)

        render(json: Api::Response.body(true, 200, data))
      end
    end
  end
end
