# frozen_string_literal: true

module Jwt
  class Wrapper
    def self.encode(payload, exp = nil)
      payload[:exp] = 2.days.from_now.to_i if exp.nil?
      JWT.encode(payload, ENV['EM_API_SECRETE'])
    end

    def self.decode(token)
      body = JWT.decode(token, ENV['EM_API_SECRETE']).first
      HashWithIndifferentAccess.new(body)
    rescue StandardError
      nil
    end
  end
end
