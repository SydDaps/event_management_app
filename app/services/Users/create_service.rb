module Users
  class CreateService < BaseService
    def initialize(params)
      @name = params[:name]
      @email = params[:email]
      @password = params[:password]
    end

    def call
      fields = user_fields
      user = User.find_by(email: @email)
      raise(Exceptions::NotUniqueRecord.message('Email already taken')) if user.present?


      user = User.create(fields)
      {
        user: User.create(user_fields),
        token: Jwt::Wrapper.encode({ user_id: user.id })
      }
    end



    private

    def user_fields
      user_fields = {
        name: @name,
        email: @email,
        password: @password
      }

      raise(Exceptions::MissingParam.message('Missing Parameter')) if user_fields.values.include?(nil)

      user_fields
    end

  end
end