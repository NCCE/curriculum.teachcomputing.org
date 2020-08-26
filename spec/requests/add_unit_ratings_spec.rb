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
              title
              description
              unitGuide
              totalPositive
              totalNegative
            }
          }
        GQL
      }
    end

    it 'returns the unit information' do
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
                title
                description
                unitGuide
                totalPositive
                totalNegative
              }
            }
          GQL
        }
      end

      it 'returns the unit information' do
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
              title
              description
              unitGuide
              totalPositive
              totalNegative
            }
          }
        GQL
      }
    end

    it 'returns the unit information' do
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
                title
                description
                unitGuide
                totalPositive
                totalNegative
              }
            }
          GQL
        }
      end

      it 'returns the unit information' do
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
end
