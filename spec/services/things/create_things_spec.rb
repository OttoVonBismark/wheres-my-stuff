# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/service'

RSpec.describe Things::CreateThing do
  subject(:service) do
    permitted_service(
      service: described_class,
      permissions: :member
    )
  end

  let(:thing_params) {
    {
      name: 'Some Thing',
      user_id: service.user.id,
      price: 10.0,
      ordered_on: Date.today
    }
  }

  include_examples('unpermitted service')

  context 'Creating a Thing' do
    context 'with valid parameters' do
      it 'creates the Thing' do
        response = service.call(thing_params: thing_params)
        new_thing = response.data
        
        expect(response.success?).to be true
        expect(new_thing).to_not be nil
        expect(Thing.find(new_thing.id)).to eq new_thing
      end
    end

    context 'with invalid parameters' do
      it 'fails without a name' do
        response = service.call(thing_params: thing_params.except(:name))
        new_thing = response.data

        expect(response.success?).to be false
        expect { Thing.find(new_thing.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
