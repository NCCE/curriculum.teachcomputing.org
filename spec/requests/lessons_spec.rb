require 'rails_helper'

RSpec.describe 'Lesson', type: :request do
  let!(:published_lesson) { create(:published_lesson) }

  before do
    create(:lesson)
  end

  describe 'list Lessons' do
    it 'returns lessons' do
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
                objectives
                zippedContents
              }
          }
        GQL
      }
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
            objectives: published_lesson.objectives,
            zippedContents: nil
          }]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end
end
