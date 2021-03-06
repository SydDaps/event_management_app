# frozen_string_literal: true

module Auth
  class AuthorizeService < BaseService
    def initialize(headers = {})
      @headers = headers
    end

    def call
      user
    end

    private

    def user
      @user ||= User.find(decode_auth_token[:user_id]) if decode_auth_token

      raise(Exceptions::UnauthorizedOperation.message('User Not found')) unless @user

      @user
    end

    def decode_auth_token
      @decoded_token ||= Jwt::JsonWebToken.decode(http_auth_header)
      raise(Exceptions::ExpiredToken.message('Session Expired login again')) unless @decoded_token

      @decoded_token
    end

    def http_auth_header
      return @headers['HTTP_AUTHORIZATION'].split(' ').last if @headers.present?

      raise(Exceptions::UnauthorizedOperation.message('Missing Token'))
    end
  end
end
