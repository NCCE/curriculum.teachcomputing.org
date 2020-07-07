require 'rails_helper'

RSpec.describe 'Authenticate requests', type: :request do
  before do
    # Ensure we go into the actual auth check
    allow(Rails.env).to receive(:test?).and_return(false)
  end

  context 'when no auth token' do
    it 'returns 401' do
      post '/graphql', params: { query: '{ keyStages { id } }' }
      expect(response).to be_unauthorized
    end
  end

  context 'when auth token correct' do
    it 'returns 200' do
      post '/graphql',
           headers: { 'AUTHORIZATION' => "Token token=\"#{ENV['API_KEY']}\"" },
           params: { query: '{ keyStages { id } }' }
      expect(response).to be_successful
    end
  end

  context 'when auth token incorrect' do
    it 'returns 401' do
      post '/graphql',
           headers: { 'AUTHORIZATION' => 'Token token="incorrectapikey"' },
           params: { query: '{ keyStages { id } }' }
      expect(response).to be_unauthorized
    end
  end
end
