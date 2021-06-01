# frozen_string_literal: true

module Users
  # **Create User**
  #
  # Service to create a new User. No permissions are assigned until confirmation.
  class CreateUser < Service
    include Authorization::BypassPermissions

    # Create a User based on given parameters.
    # @param user_info [ActionController::Parameters] The parameters for the new User.
    # @return [Response] Contains success/fail information as well as the newly created User
    def call(user_info:)
      result = User.transaction(requires_new: true) do
        create_user(user_info)
      end

      response.success = true if result == :success
      response
    end

    private

    def create_user(user_params)
      user = User.create(user_params)
      response.data = user

      if user.persisted?
        :success
      else
        response.messages.concat(user.errors.full_messages)
        :errors
      end
    end
  end
end
