# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Thing, type: :model do
  let(:valid_attributes) {
    {
      name: 'Some Thing'
    }
  }

  describe 'Creating a Thing' do
    context 'with valid attributes' do
      it 'creates a Thing' do
        thing = Thing.new(valid_attributes)
        expect(thing).to be_valid
      end
    end

    context 'without valid attributes' do
      it 'rejects the Thing' do
        thing = Thing.new
        expect(thing).to_not be_valid
      end
    end
  end
end
