# frozen_string_literal: true

module Things
  # **Create Thing**
  #
  # Service to create a Thing. Pretty basic, but portable and ensures authorization.
  class CreateThing < Service
    allow_permissions! :member

    # Create a Thing based on the given parameters.
    # @param thing_params [ActionController::Parameters] The parameters for the new Thing.
    # @return [Response] Contains success/fail information as well as the new Thing in `data`.
    def call(thing_params:)
      result = Thing.transaction(requires_new: true) do
        create_thing(thing_params)
      end

      response.success = true if result == :success
      response
    end

    private

    def create_thing(thing_params)
      thing = Thing.create(thing_params)
      response.data = thing

      if thing.persisted?
        :success
      else
        response.messages.concat(thing.errors.full_messages)
        :errors
      end
    end
  end
end
