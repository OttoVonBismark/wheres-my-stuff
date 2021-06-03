# frozen_string_literal: true

module Permissions
  # Sets the bare-minimum permissions necessary to interact with the application.
  # Auto-fires during the Users::ConfirmUser process, but can also be used to reset permissions.
  class SetBasePermissions < Service
    include Authorization::BypassPermissions

    def call(user:)
      result = Permission.transaction(requires_new: true) do
        apply_base_permissions(user)
      end

      response.success = true if result == :success
      response
    end

    private

    def apply_base_permissions(user)
      # Clear the field
      user.permissions.each(&:destroy) if user.permissions.any?

      perm = Permission.create(user: user, allowed: 'member')

      if perm.persisted?
        :success
      else
        response.messages.concat(perm.errors.full_messages)
        :errors
      end
    end
  end
end
