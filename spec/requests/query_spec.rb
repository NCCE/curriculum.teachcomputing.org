require 'rails_helper'

RSpec.describe 'Query', type: :request do
  let!(:published_key_stages) { create_list(:published_key_stage, 3) }
  let!(:published_year_groups) { create_list(:published_year_group, 3) }
  let!(:published_units) { create_list(:published_unit, 3) }
  let!(:published_lessons) { create_list(:published_lesson, 3) }

  before do
    create(:key_stage)
  end

  describe 'parameter handling' do
    context 'with a keyStage query' do
      it 'returns the expected value when an id is passed' do
        post '/graphql', params: {
          query: <<~GQL
            {
              keyStage(id: "#{published_key_stages[0].id}")
                {
                  id
                  slug
                }
            }
          GQL
        }
        expect(response).to be_successful
        expected_response = {
          data: {
            keyStage: {
              id: published_key_stages[0].id,
              slug: published_key_stages[0].slug
            }
          }
        }.to_json
        expect(response.body).to eq(expected_response)
      end

      it 'returns the expected value when a slug is passed' do
        post '/graphql', params: {
          query: <<~GQL
            {
              keyStage(slug: "#{published_key_stages[0].slug}")
                {
                  id
                  slug
                }
            }
          GQL
        }
        expect(response).to be_successful
        expected_response = {
          data: {
            keyStage: {
              id: published_key_stages[0].id,
              slug: published_key_stages[0].slug
            }
          }
        }.to_json
        expect(response.body).to eq(expected_response)
      end

      it 'returns the expected number of items when a limit is set' do
        post '/graphql', params: {
          query: <<~GQL
            {
              keyStages(limit: 2)
                {
                  id
                }
            }
          GQL
        }
        expect(response).to be_successful
        expected_response = {
          data: { keyStages: [{ id: published_key_stages[0].id }, { id: published_key_stages[1].id }] }
        }.to_json
        expect(response.body).to eq(expected_response)
      end
    end

    context 'with a yearGroup query' do
      it 'returns the expected number of items when a limit is set' do
        post '/graphql', params: {
          query: <<~GQL
            {
              yearGroups(limit: 2)
                {
                  id
                }
            }
          GQL
        }
        expect(response).to be_successful
        expected_response = {
          data: { yearGroups: [{ id: published_year_groups[0].id }, { id: published_year_groups[1].id }] }
        }.to_json
        expect(response.body).to eq(expected_response)
      end
    end

    context 'with a unit query' do
      it 'returns the expected number of items when a limit is set' do
        post '/graphql', params: {
          query: <<~GQL
            {
              units(limit: 2)
                {
                  id
                }
            }
          GQL
        }
        expect(response).to be_successful
        expected_response = {
          data: { units: [{ id: published_units[0].id }, { id: published_units[1].id }] }
        }.to_json
        expect(response.body).to eq(expected_response)
      end
    end

    context 'with a lesson query' do
      it 'returns the expected number of items when a limit is set' do
        post '/graphql', params: {
          query: <<~GQL
            {
              lessons(limit: 2)
                {
                  id
                }
            }
          GQL
        }
        expect(response).to be_successful
        expected_response = {
          data: { lessons: [{ id: published_lessons[0].id }, { id: published_lessons[1].id }] }
        }.to_json
        expect(response.body).to eq(expected_response)
      end
    end
  end

  describe 'when a record is not found' do
    context 'with a keyStage query' do
      it 'null is returned and an error is added to the response' do
        post '/graphql', params: {
          query: <<~GQL
            {
              keyStage(slug: "nonsense") {
                id
              }
            }
          GQL
        }
        expect(response).to be_successful
        expected_response = {
          data: {
            keyStage: nil
          },
          errors: [
            {
              message: 'KeyStage not found',
              locations: [
                {
                  line: 2,
                  column: 3
                }
              ],
              path: [
                'keyStage'
              ],
              extensions: {
                code: :not_found
              }
            }
          ]
        }.to_json
        expect(response.body).to eq(expected_response)
      end
    end
  end
end
