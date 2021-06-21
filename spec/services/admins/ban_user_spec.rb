# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/service'

RSpec.describe Admins::BanUser do
  subject(:service) do
    permitted_service(
      service: described_class,
      permissions: :admin
    )
  end

  let!(:user) { create(:user) }
  let!(:banned_user) { create(:user, :banned) }
  let!(:admin_user) { create(:user, with_permissions: %w[member admin]) }

  include_examples('unpermitted service')

  context 'Banning a User' do
    it 'bans the User' do
      response = service.call(user: user)

      expect(response.success?).to be true
      expect(user.banned_on).to_not be nil
    end

    it 'does not double-ban a banned User' do
      response = service.call(user: banned_user)

      expect(response.success?).to be false
      expect(banned_user.banned_on).to_not be nil
    end

    it 'does not ban Admins' do
      response = service.call(user: admin_user)

      expect(response.success?).to be false
      expect(admin_user.banned_on).to be nil
    end
  end
end
