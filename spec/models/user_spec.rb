# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_attributes) do
    {
      email: 'user@example.com',
      username: 'example',
      password: 'foobarbaz',
      password_confirmation: 'foobarbaz'
    }
  end

  describe 'Creating a User' do
    context 'with valid attributes' do
      it 'creates the User' do
        user = User.new(valid_attributes)

        expect(user).to be_valid

        expect { user.save }.to change { User.count }.by(1)
        user.reload

        expect(user.id).to_not be nil
      end
    end
    context 'with invalid attributes' do
      it 'rejects a User with a blank email' do
        user = User.new(
          email: '',
          username: 'example',
          password: 'foobarbaz',
          password_confirmation: 'foobarbaz'
        )

        expect(user).to_not be_valid
      end

      it 'rejects a User with a missing email' do
        user = User.new(valid_attributes.except(:email))

        expect(user).to_not be_valid
      end

      it 'rejects a User with a blank username' do
        user = User.new(
          email: 'user@example.com',
          username: '',
          password: 'foobarbaz',
          password_confirmation: 'foobarbaz'
        )

        expect(user).to_not be_valid
      end

      it 'rejects a User with a missing username' do
        user = User.new(valid_attributes.except(:username))

        expect(user).to_not be_valid
      end

      it 'rejects a User with a short password' do
        user = User.new(
          email: 'user@example.com',
          username: 'example',
          password: 'foobar',
          password_confirmation: 'foobar'
        )

        expect(user).to_not be_valid
      end

      it 'rejects a User with a missing password' do
        user = User.new(valid_attributes.except(:password))

        expect(user).to_not be_valid
      end
    end
  end
end
