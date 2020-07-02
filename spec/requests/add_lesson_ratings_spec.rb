require 'rails_helper'

RSpec.describe 'Add Lesson Rating', type: :request do
  let(:published_lesson) { create(:published_lesson) }

  describe 'add positive rating' do
    it 'returns the lesson information' do
      query = {
        query: <<~GQL
          mutation {
            addPositiveLessonRating(
              id: "#{published_lesson.id}"
            )
            {
              id
              title
              description
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
          addPositiveLessonRating: {
            id: published_lesson.id,
            title: published_lesson.title,
            description: published_lesson.description,
            totalPositive: 1,
            totalNegative: 0
          }
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end

  describe 'add negative rating' do
    it 'returns the lesson information' do
      query = {
        query: <<~GQL
          mutation {
            addNegativeLessonRating(
              id: "#{published_lesson.id}"
            )
            {
              id
              title
              description
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
          addNegativeLessonRating: {
            id: published_lesson.id,
            title: published_lesson.title,
            description: published_lesson.description,
            totalPositive: 0,
            totalNegative: 1
          }
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end
end
