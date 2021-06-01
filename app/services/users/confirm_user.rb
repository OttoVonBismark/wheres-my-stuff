# frozen_string_literal: true

module Users
  # Confirm user with a matching confirmation token
  # This will fail if a user does not have a password set
  class ConfirmUser < Service
    include Authorization::BypassPermissions

    # Confirm a User with the given token and create their Permissions.
    # @param user [User] The User to be confirmed.
    # @return [Response] Contains success/fail information.
    def call(user:)
      if user.needs_confirmation?
        User.transaction(requires_new: true) do
          confirm_user(user)
        end
      elsif user.confirmed_at.present?
        user.errors.add(:email, user_already_confirmed)
        response.status = :errors
      end

      response
    end

    private

    def confirm_user(user)
      user.confirm
      Permissions::SetBasePermissions.call(user: user)
      response.status = :complete
    end

    def user_already_confirmed
      I18n.t('errors.messages.already_confirmed')
    end
  end
end
