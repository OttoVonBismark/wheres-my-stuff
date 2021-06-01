# frozen_string_literal: true

class Service
  # Basic response object for consistent returns
  class Response
    attr_accessor :authorized, :data, :messages, :success, :status

    def initialize
      @authorized = false
      @data = nil
      @messages = []
      @success = false
      @status = nil
    end

    def success?
      return false unless authorized

      success
    end
  end
end
