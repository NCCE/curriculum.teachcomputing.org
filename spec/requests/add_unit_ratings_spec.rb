require 'rails_helper'

RSpec.describe 'Add Unit Rating', type: :request do
  let(:published_unit) { create(:published_unit) }
  let(:user_stem_achiever_contact_no) { SecureRandom.uuid }

  describe 'add positive rating' do
    let(:query) do
      {
        query: <<~GQL
          mutation {
            addPositiveUnitRating(
              id: "#{published_unit.id}"
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

    it 'returns the unit information' do
      post '/graphql', params: query
      expect(response).to be_successful
      rating = JSON.parse(response.body, object_class: OpenStruct).data.addPositiveUnitRating
      expect(rating.comment).to be_nil
      expect(Rating.find(rating.id)).to be_a(Rating)
    end

    it 'calls add_positive_rating method with the stem achiever number' do
      expect_any_instance_of(Unit)
        .to receive(:add_positive_rating).with(user_stem_achiever_contact_no)
      post '/graphql', params: query
    end

    context 'when no achiever contact number' do
      let(:query) do
        {
          query: <<~GQL
            mutation {
              addPositiveUnitRating(
                id: "#{published_unit.id}"
              )
              {
                id
              }
            }
          GQL
        }
      end

      it 'returns the unit information' do
        post '/graphql', params: query
        expect(response).to be_successful
        rating = JSON.parse(response.body, object_class: OpenStruct).data.addPositiveUnitRating
        expect(Rating.find(rating.id)).to be_a(Rating)
      end
    end
  end

  describe 'add negative rating' do
    let(:query) do
      {
        query: <<~GQL
          mutation {
            addNegativeUnitRating(
              id: "#{published_unit.id}"
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

    it 'returns the unit information' do
      post '/graphql', params: query
      expect(response).to be_successful
      rating = JSON.parse(response.body, object_class: OpenStruct).data.addNegativeUnitRating
      expect(rating.comment).to be_nil
      expect(Rating.find(rating.id)).to be_a(Rating)
    end

    it 'calls add_negative_rating method with the stem achiever number' do
      expect_any_instance_of(Unit)
        .to receive(:add_negative_rating).with(user_stem_achiever_contact_no)
      post '/graphql', params: query
    end

    context 'when no achiever number sent' do
      let(:query) do
        {
          query: <<~GQL
            mutation {
              addNegativeUnitRating(
                id: "#{published_unit.id}"
              )
              {
                id
              }
            }
          GQL
        }
      end

      it 'returns the unit information' do
        post '/graphql', params: query
        expect(response).to be_successful
        rating = JSON.parse(response.body, object_class: OpenStruct).data.addNegativeUnitRating
        expect(Rating.find(rating.id)).to be_a(Rating)
      end
    end
  end
end
