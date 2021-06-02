# frozen_string_literal: true

RSpec.shared_examples 'unpermitted service' do
  it 'should fail if not permitted' do
    expect { described_class.call }.to raise_exception(Authorization::NotAuthorizedError, 'User does not have access')
  end
end
