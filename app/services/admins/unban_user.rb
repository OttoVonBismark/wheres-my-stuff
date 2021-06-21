# frozen_string_literal: true

module Admins
  # Unbans the banned user by clearing `banned_at`.
  # Requires `:admin` permission.
  class UnbanUser < Service
    allow_permissions! :admin

    # Unban the specified user effective immediately.
    # @param user [User] The User you are unbanning.
    # @return [Response] Contains success/fail information.
    def call(user:)
      result = User.transaction(requires_new: true) do
        unban_user(user)
      end

      response.success = true if result == :success
      response
    end

    private

    # Unban the user only if they're banned.
    def unban_user(user)
      return :errors if user.banned_on.nil?

      user.unban!
      user.reload

      if user.banned_on.nil?
        :success
      else
        :errors
      end
    end
  end
end
