require 'rails_helper'

RSpec.describe 'Assessment', type: :request do
  let!(:published_assessment) { create(:published_assessment) }

  before do
    create(:assessment)
  end

  describe 'list Assessments' do
    it 'returns published assessments' do
      post '/graphql', params: {
        query: <<~GQL
          {
            assessments
              {
                id
                unit {
                  id
                }
                title
                description
                rubric
                sheets
                summativeAssessment
              }
          }
        GQL
      }
      expect(response).to be_successful

      expected_response = {
        data: {
          assessments: [{
            id: published_assessment.id,
            unit: {
              id: published_assessment.unit.id
            },
            title: published_assessment.title,
            description: published_assessment.description,
            rubric: nil,
            sheets: [],
            summativeAssessment: nil
          }]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end
end
