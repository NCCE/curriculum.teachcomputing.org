require 'rails_helper'

RSpec.describe Unit, type: :request do
  before do
    create(:unit)
  end

  describe 'list Units' do
    let!(:published_unit) { create(:published_unit) }

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
                slug
                description
                isaacUrl
                unitGuide {
                  filename
                }
                totalPositive
                totalNegative
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
            slug: published_unit.slug,
            description: published_unit.description,
            isaacUrl: published_unit.isaac_url,
            unitGuide: {
              filename: 'test.txt'
            },
            totalPositive: 0,
            totalNegative: 0
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

  describe 'when ordering' do
    let!(:unit_2) { create(:published_unit, order: 1, title: 'Unit 2') }
    let!(:unit_3) { create(:published_unit, order: 3, title: 'Unit 3') }
    let!(:unit_1) { create(:published_unit, order: 2, title: 'Unit 1') }

    before do
      post '/graphql', params: {
        query: <<~GQL
          {
            units
              {
                slug
                order
              }
          }
        GQL
      }
    end

    it 'returns units in the defined order' do
      expect(response).to be_successful

      expected_response = {
        data: {
          units: [
            {
              slug: unit_2.slug,
              order: 1
            },
            {
              slug: unit_1.slug,
              order: 2
            },
            {
              slug: unit_3.slug,
              order: 3
            }
          ]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end
end
