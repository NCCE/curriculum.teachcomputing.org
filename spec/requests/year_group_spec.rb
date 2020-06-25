require 'rails_helper'

RSpec.describe 'YearGroup', type: :request do
  let!(:published_year_group) { create(:published_year_group) }

  before do
    create(:year_group)
  end

  describe 'list Year Groups' do
    it 'returns published year groups' do
      post '/graphql', params: {
        query: <<~GQL
          {
            yearGroups
              {
                id
                yearNumber
                description
              }
          }
        GQL
      }
      expect(response).to be_successful

      expected_response = {
        data: {
          yearGroups: [{
            id: published_year_group.id,
            yearNumber: published_year_group.year_number,
            description: published_year_group.description
          }]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end
end
