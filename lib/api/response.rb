# frozen_string_literal: true

module Api
  class Response
    def self.body(success_status, code, data)
      response_data = {
        success: success_status,
        code: code
      }

      response_data.merge(data: data) if data.present?
    end
  end
end
