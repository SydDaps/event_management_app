# frozen_string_literal: true

module Auth
  class AuthenticateService < BaseService
    def initialize(auth_fields)
      @email = auth_fields[:email]
      @password = auth_fields[:password]
    end

    def call
      {
        token: Jwt::Wrapper.encode({ user_id: user.id }),
        user: user
      }
    end

    private

    def user
      user = User.find_by(email: @email)
      return user if user&.authenticate(@password)

      raise(Exceptions::UnauthorizedOperation.message('Check Email or password'))
    end
  end
end
