# frozen_string_literal: true

# RSpec authorization helpers
module Authorization
  module Test
    module Helpers
      def permitted_service(service:, permissions:)
        Authorization::AuthorizePolicy.new(service, create(:user, with_permissions: permissions))
      end
    end
  end
end
