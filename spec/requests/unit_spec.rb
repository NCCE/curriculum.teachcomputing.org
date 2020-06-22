require 'rails_helper'

RSpec.describe Unit, type: :request do
  let!(:published_unit) { create(:published_unit) }

  before do
    create(:unit)
  end

  describe 'list Units' do
    it 'returns units' do
      post '/graphql', params: {
        query: <<~GQL
          {
            units
              {
              id
              title
              description
              }
          }
        GQL
      }
      expect(response).to be_successful

      expected_response = {
        data: {
          units: [{
            id: published_unit.id,
            title: published_unit.title,
            description: published_unit.description
          }]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end
end
