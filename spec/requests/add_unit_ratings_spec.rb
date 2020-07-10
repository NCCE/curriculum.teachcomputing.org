require 'rails_helper'

RSpec.describe 'Add Unit Rating', type: :request do
  let(:published_unit) { create(:published_unit) }

  describe 'add positive rating' do
    it 'returns the unit information' do
      query = {
        query: <<~GQL
          mutation {
            addPositiveUnitRating(
              id: "#{published_unit.id}"
            )
            {
              id
              title
              description
              unitGuide
              totalPositive
              totalNegative
            }
          }
        GQL
      }

      post '/graphql', params: query
      expect(response).to be_successful

      expected_response = {
        data: {
          addPositiveUnitRating: {
            id: published_unit.id,
            title: published_unit.title,
            description: published_unit.description,
            unitGuide: nil,
            totalPositive: 1,
            totalNegative: 0
          }
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end

  describe 'add negative rating' do
    it 'returns the unit information' do
      query = {
        query: <<~GQL
          mutation {
            addNegativeUnitRating(
              id: "#{published_unit.id}"
            )
            {
              id
              title
              description
              unitGuide
              totalPositive
              totalNegative
            }
          }
        GQL
      }

      post '/graphql', params: query
      expect(response).to be_successful

      expected_response = {
        data: {
          addNegativeUnitRating: {
            id: published_unit.id,
            title: published_unit.title,
            description: published_unit.description,
            unitGuide: nil,
            totalPositive: 0,
            totalNegative: 1
          }
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end
end
