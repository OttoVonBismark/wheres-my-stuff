# frozen_string_literal: true

# Base Class for Service objects, handy utilities that can be invoked from anywhere.
class Service
  attr_reader :current_user, :policy, :response

  class << self
    attr_accessor :required_permissions

    def call(*positional, **keyword)
      service = new
      fail! unless service.authorized?

      service.call(*positional, **keyword)
    end

    def allow_permissions!(permissions)
      self.required_permissions = permissions
    end

    def fail!
      raise(Authorization::NotAuthorizedError, 'User does not have access')
    end
  end

  def initialize(user: nil, policy: nil)
    @current_user = user
    @policy = policy
    @response = Service::Response.new
  end

  def authorized?
    response.authorized
  end

  def authorize!
    response.authorized = true
  end

  def permit(klass)
    Authorization::AuthorizePolicy.new(klass, current_user)
  end

  def set_response_messages(object:, action:)
    response.messages <<
      I18n.t(response.status, scope: [:globals, action], object_name: object.class.model_name.human)

    response.messages.concat(object.errors.full_messages)
  end
end
