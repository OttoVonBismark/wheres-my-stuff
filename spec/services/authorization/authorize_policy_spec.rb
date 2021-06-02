# frozen_string_literal: true

require 'rails_helper'

# Authorize Policy Test Class
class AuthorizePolicyTestClass
  def self.required_permissions
    :can_do
  end

  def initialize(user:, policy:)
    @user = user
    @policy = policy
  end

  def call(param1 = :param1)
    param1
  end

  def authorize!
    true
  end
end

RSpec.describe Authorization::AuthorizePolicy do
  let(:user) { instance_double('User') }

  context '.call' do
    let(:test_class) { AuthorizePolicyTestClass }

    it 'is successful if allowed' do
      allow(user).to receive(:check_permissions?).with(:can_do).and_return(true)

      results = Authorization::AuthorizePolicy.new(test_class, user).call(:success)

      expect(results).to eq :success
    end

    it 'is prevented if not allowed' do
      allow(user).to receive(:check_permissions?).with(:can_do).and_return(false)

      expect {
        Authorization::AuthorizePolicy.new(test_class, user).call(:success)
      }.to raise_error Authorization::NotAuthorizedError
    end

    it 'is prevented if user is nil' do
      expect {
        Authorization::AuthorizePolicy.new(test_class, nil).call(:success)
      }.to raise_error Authorization::NotAuthorizedError
    end
  end

  context '.authorize!' do
    it 'returns true if it passes the permission check' do
      allow(user).to receive(:check_permissions?).with(:can_do).and_return(true)

      expect(Authorization::AuthorizePolicy.authorize!(:can_do, user)).to be true
    end

    it 'raises an error if it fails the permission check' do
      allow(user).to receive(:check_permissions?).with(:can_do).and_return(false)

      expect {
        Authorization::AuthorizePolicy.authorize!(:can_do, user)
      }.to raise_error Authorization::NotAuthorizedError
    end
  end
end
