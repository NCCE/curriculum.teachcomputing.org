require 'rails_helper'

RSpec.describe 'Add Lesson Rating', type: :request do
  let(:published_lesson) { create(:published_lesson) }
  let(:user_stem_achiever_contact_no) { SecureRandom.uuid }

  describe 'add positive rating' do
    let(:query) do
      { query: <<~GQL
        mutation {
          addPositiveLessonRating(
            id: "#{published_lesson.id}"
            userStemAchieverContactNo: "#{user_stem_achiever_contact_no}"
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
    end

    it 'returns the lesson information' do
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

    it 'calls add_positive_rating method with the stem achiever number' do
      expect_any_instance_of(Lesson)
        .to receive(:add_positive_rating).with(user_stem_achiever_contact_no)
      post '/graphql', params: query
    end

    context 'when no achiever number included' do
      let(:query) do
        { query: <<~GQL
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
      end

      it 'returns the lesson information' do
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
  end

  describe 'add negative rating' do
    let(:query) do
      {
        query: <<~GQL
          mutation {
            addNegativeLessonRating(
              id: "#{published_lesson.id}"
              userStemAchieverContactNo: "#{user_stem_achiever_contact_no}"
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
    end

    it 'returns the lesson information' do
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

    it 'calls add_negative_rating method with the stem achiever number' do
      expect_any_instance_of(Lesson)
        .to receive(:add_negative_rating).with(user_stem_achiever_contact_no)
      post '/graphql', params: query
    end

    context 'when no achiever number included' do
      let(:query) do
        {
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
      end

      it 'returns the lesson information' do
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
end
