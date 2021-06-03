# frozen_string_literal: true

# Authorization module
module Authorization
  # Helpers module
  module Helpers
    Permission.supported_permissions.each do |permission|
      define_method :"authorize_#{permission}!" do
        Authorization::AuthorizePolicy.authorize!(permission, current_user)
      end
    end

    def permit(klass)
      Authorization::AuthorizePolicy.new(klass, current_user)
    end
  end
end
