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
                unitGuide
                totalPositive
                totalNegative
                learningGraphs
                rubrics
                summativeAssessments
                summativeAnswers
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
            unitGuide: nil,
            totalPositive: 0,
            totalNegative: 0,
            learningGraphs: [],
            rubrics: [],
            summativeAssessments: [],
            summativeAnswers: []
          }]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end

    it 'only returns published assessments' do
      published_assessment = create(:published_assessment,
                                    title: 'Published Assessment',
                                    unit: published_unit)
      create(:assessment, unit: published_unit)

      post '/graphql', params: {
        query: <<~GQL
          {
            units
              {
                id
                title
                assessments {
                  id
                  title
                }
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
            assessments: [{
              id: published_assessment.id,
              title: published_assessment.title
            }]
          }]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end

    it 'only returns published lessons' do
      published_lesson = create(:published_lesson,
                                title: 'Published Lesson',
                                unit: published_unit)
      create(:lesson, unit: published_unit)

      post '/graphql', params: {
        query: <<~GQL
          {
            units
              {
                id
                title
                lessons {
                  id
                  title
                }
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
            lessons: [{
              id: published_lesson.id,
              title: published_lesson.title
            }]
          }]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end
end
