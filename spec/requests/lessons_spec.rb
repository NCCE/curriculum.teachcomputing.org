require 'rails_helper'

RSpec.describe 'Lesson', type: :request do
  let!(:published_lesson) { create(:published_lesson) }

  describe 'for a primary lesson' do
    let!(:primary_learning_objectives) do
      [
        create(:learning_objective, lesson: published_lesson, order: 2, description: 'MyString 2'),
        create(:learning_objective, lesson: published_lesson, order: 1, description: 'MyString 1')
      ]
    end

    before do
      post '/graphql', params: {
        query: <<~GQL
          {
            lessons
              {
                id
                unit {
                  id
                }
                title
                slug
                description
                zippedContents
                learningObjectives {
                  description
                  successCriteria {
                    description
                  }
                }
              }
          }
        GQL
      }
    end

    it 'returns lessons with the expected learning objectives' do
      expect(response).to be_successful

      expected_response = {
        data: {
          lessons: [{
            id: published_lesson.id,
            unit: {
              id: published_lesson.unit.id
            },
            title: published_lesson.title,
            slug: published_lesson.slug,
            description: published_lesson.description,
            zippedContents: nil,
            learningObjectives: [
              {
                description: 'MyString 1',
                successCriteria: []
              },
              {
                description: 'MyString 2',
                successCriteria: []
              }
            ]
          }]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end

  describe 'for a secondary lesson' do
    let!(:secondary_learning_objective) do
      create(:learning_objective, lesson: published_lesson)
    end

    let!(:secondary_success_criteria) do
      [
        create(:success_criterion, description: 'MyString 3', order: '2',
                                   learning_objective: secondary_learning_objective),
        create(:success_criterion, description: 'MyString 1', order: '3',
                                   learning_objective: secondary_learning_objective),
        create(:success_criterion, description: 'MyString 2', order: '1',
                                   learning_objective: secondary_learning_objective)
      ]
    end

    before do
      post '/graphql', params: {
        query: <<~GQL
          {
            lessons
              {
                id
                unit {
                  id
                }
                title
                slug
                description
                zippedContents
                learningObjectives {
                  description
                  successCriteria {
                    description
                  }
                }
              }
          }
        GQL
      }
    end

    it 'returns lessons with the expected success criteria' do
      expect(response).to be_successful

      expected_response = {
        data: {
          lessons: [{
            id: published_lesson.id,
            unit: {
              id: published_lesson.unit.id
            },
            title: published_lesson.title,
            slug: published_lesson.slug,
            description: published_lesson.description,
            zippedContents: nil,
            learningObjectives: [
              {
                description: 'MyString',
                successCriteria: [
                  {
                    description: 'MyString 2'
                  },
                  {
                    description: 'MyString 3'
                  },
                  {
                    description: 'MyString 1'
                  }
                ]
              }
            ]
          }]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end
end
