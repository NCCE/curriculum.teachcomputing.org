require 'rails_helper'

RSpec.describe 'GraphQL API', type: :request do
  describe 'empty request' do
    it 'asks the client not to sniff MIME types' do
      post '/graphql', params: { query: '{}' }
      expect(response).to be_successful
      expect(response.headers['X-Content-Type-Options']).to eq('nosniff')
    end
  end
end
