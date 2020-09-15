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
            comment
          }
        }
      GQL
      }
    end

    it 'returns a rating' do
      post '/graphql', params: query
      expect(response).to be_successful
      rating = JSON.parse(response.body, object_class: OpenStruct).data.addPositiveLessonRating
      expect(rating.comment).to be_nil
      expect(Rating.find(rating.id)).to be_a(Rating)
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
            }
          }
        GQL
        }
      end

      it 'returns a rating' do
        post '/graphql', params: query
        expect(response).to be_successful
        rating = JSON.parse(response.body, object_class: OpenStruct).data.addPositiveLessonRating
        expect(Rating.find(rating.id)).to be_a(Rating)
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
              comment
            }
          }
        GQL
      }
    end

    it 'returns a rating' do
      post '/graphql', params: query
      expect(response).to be_successful
      rating = JSON.parse(response.body, object_class: OpenStruct).data.addNegativeLessonRating
      expect(rating.comment).to be_nil
      expect(Rating.find(rating.id)).to be_a(Rating)
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
              }
            }
          GQL
        }
      end

      it 'returns a rating' do
        post '/graphql', params: query
        expect(response).to be_successful
        rating = JSON.parse(response.body, object_class: OpenStruct).data.addNegativeLessonRating
        expect(Rating.find(rating.id)).to be_a(Rating)
      end
    end
  end
end
