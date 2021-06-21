# frozen_string_literal: true

module Admins
  # Bans the user by setting `banned_at`.
  # Reversible with `Admins::UnbanUser`
  # Requires `:admin` permission.
  class BanUser < Service
    allow_permissions! :admin

    # Ban the specified user effective immediately.
    # @param user [User] The User you wish to ban.
    # @return [Response] Contains success/fail information.
    def call(user:)
      result = User.transaction(requires_new: true) do
        ban_user(user)
      end

      response.success = true if result == :success
      response
    end

    private

    # Ban the user only if they aren't already banned and are not an Admin.
    def ban_user(user)
      return :errors unless user.banned_on.nil?
      return :errors if user.check_permissions?(:admin)

      user.ban!
      user.reload

      if user.banned_on.nil?
        :errors
      else
        :success
      end
    end
  end
end
