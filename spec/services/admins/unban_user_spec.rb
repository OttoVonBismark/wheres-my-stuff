# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/service'

RSpec.describe Admins::UnbanUser do
  subject(:service) do
    permitted_service(
      service: described_class,
      permissions: :admin
    )
  end

  let!(:user) { create(:user) }
  let!(:banned_user) { create(:user, :banned) }

  include_examples('unpermitted service')

  context 'Unbanning a User' do
    it 'unbans a banned User' do
      response = service.call(user: banned_user)

      expect(response.success?).to be true
      expect(banned_user.banned_on).to be nil
    end

    it "does not unban a User who wasn't banned to begin with" do
      response = service.call(user: user)

      expect(response.success?).to be false
    end
  end
end
