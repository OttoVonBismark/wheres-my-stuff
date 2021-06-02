# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Permissions::SetBasePermissions do
  subject(:service) { described_class }

  let!(:user) { create(:user, with_permissions: %w[member admin]) }

  context 'Calling the service' do
    it 'sets base permissions for a new user' do
      new_user = User.create(
        email: 'new_user@example.com',
        username: 'new_user',
        password: 'foobarbaz',
        password_confirmation: 'foobarbaz'
      )

      response = service.call(user: new_user)
      new_user.reload

      expect(response.success?).to be true
      expect(new_user.check_permissions?(:member)).to be true
    end

    it 'resets the permissions to defaults for an existing user' do
      response = service.call(user: user)
      user.reload

      expect(response.success?).to be true
      expect(user.check_permissions?(:member)).to be true
      expect(user.check_permissions?(:admin)).to be false
    end

    it 'fails if no user is given' do
      expect { service.call }.to raise_error ArgumentError
    end
  end
end
