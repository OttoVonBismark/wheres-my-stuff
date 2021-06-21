# frozen_string_literal: true

module Permissions
  # Grants administrative permission to the specified user.
  # This is meant to be used only from the console and nowhere else.
  # To undo this, refer to `Permissions::SetBasePermissions`.
  # This service is also named such to be portable to other codebases as a drop-in with minimal reconfiguration.
  class GrantAdmin < Service
    include Authorization::BypassPermissions

    # Grant the `:admin` permission to the specified `user`.
    # @param user [User] The user you're making an Admin.
    # @return [Response] Contains success/fail information.
    def call(user:)
      result = Permission.transaction(requires_new: true) do
        grant_admin(user)
      end

      response.success = true if result == :success
      response
    end

    private

    def grant_admin(user)
      # If the user is already an admin, do nothing.
      if user.check_permissions?(:admin)
        # Response messages are an array, so we wrap this note in a single-element array.
        message = ["#{user.username} already has administrative priviledges. Nothing to do."]
        response.messages.concat(message)
        :errors
      else
        perm = Permission.create(user: user, allowed: 'admin')

        if perm.persisted?
          :success
        else
          response.messages.concat(perm.errors.full_messages)
          :errors
        end
      end
    end
  end
end
