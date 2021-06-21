# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Permissions::GrantAdmin do
  subject(:service) { described_class }

  let!(:user) { create(:user) }
  let!(:admin_user) { create(:user, with_permissions: %w[member admin]) }

  context 'Granting a User Admin rights' do
    it 'grants permission' do
      response = service.call(user: user)

      user.reload

      expect(response.success?).to be true
      expect(user.check_permissions?(:admin)).to be true
    end

    it 'does not work on existing Admins' do
      response = service.call(user: admin_user)

      admin_user.reload

      expect(response.success?).to be false
      expect(response.messages).to include(
        "#{admin_user.username} already has administrative privileges. Nothing to do."
      )
    end
  end
end
