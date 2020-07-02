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
                yearGroup {
                  id
                }
                title
                description
                unitOverview
                totalPositive
                totalNegative
              }
          }
        GQL
      }
      expect(response).to be_successful

      expected_response = {
        data: {
          units: [{
            id: published_unit.id,
            yearGroup: {
              id: published_unit.year_group.id
            },
            title: published_unit.title,
            description: published_unit.description,
            unitOverview: nil,
            totalPositive: 0,
            totalNegative: 0
          }]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end
end
