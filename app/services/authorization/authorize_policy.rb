# frozen_string_literal: true

# Authorization Helpers
module Authorization
  # Core policy object to authorize service objects
  class AuthorizePolicy
    class << self
      def authorize!(permissions, user)
        fail! unless user&.check_permissions?(permissions)

        true
      end

      def fail!
        raise(NotAuthorizedError, 'User does not have access')
      end
    end

    attr_reader :klass, :user

    def initialize(klass, user)
      @klass = klass
      @user = user
    end

    def respond_to_missing?(method, *)
      klass.respond_to?(method, false) || super
    end

    def method_missing(method, *args, **kwargs, &block)
      unless klass.required_permissions
        raise "You must define the required permissions in the #{klass.name} service object"
      end

      self.class.authorize!(klass.required_permissions, user)

      instance = klass.new(user: user, policy: self)
      instance.authorize!

      if instance.respond_to?(method)
        instance.public_send(method, *args, **kwargs, &block)
      else
        super
      end
    end
  end
end
