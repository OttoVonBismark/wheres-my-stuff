# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Thing, type: :model do
  let(:valid_attributes) {
    {
      name: 'Some Thing',
      price: 1.00
    }
  }

  describe 'Creating a Thing' do
    context 'with valid attributes' do
      it 'creates a Thing with a name and a price greater than zero' do
        thing = Thing.new(valid_attributes)
        expect(thing).to be_valid
      end

      it 'creates a Thing with a price of zero' do
        thing = Thing.new(name: 'Some thing', price: 0.00)
        expect(thing).to be_valid
      end
    end

    context 'without valid attributes' do
      it 'rejects the Thing without a name' do
        thing = Thing.new
        expect(thing).to_not be_valid
      end

      it 'rejects a price less than zero' do
        thing = Thing.new(name: 'Some Thing', price: -1.00)
        expect(thing).to_not be_valid
      end
    end
  end
end
