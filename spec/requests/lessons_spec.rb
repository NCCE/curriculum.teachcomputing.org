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
              title
              description
              lessonPlan
              activities
              slides
              }
          }
        GQL
      }
      expect(response).to be_successful

      expected_response = {
        data: {
          lessons: [{
            id: published_lesson.id,
            title: published_lesson.title,
            description: published_lesson.description,
            lessonPlan: nil,
            activities: [],
            slides: []
          }]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end
end
