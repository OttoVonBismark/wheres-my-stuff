# frozen_string_literal: true

module Authorization
  # The purpose of this concern is to strictly bypass authorization permissions
  # to be used from outside the app's web interface like the command line
  # or where users don't need permissions, like account confirmation,
  # thus, they don't require express permissions.
  module BypassPermissions
    extend ActiveSupport::Concern

    included do
      # Override Service#authorized?
      def authorized?
        # Service#authorize!
        authorize!
      end
    end
  end
end
