require 'rails_helper'

RSpec.describe 'Query', type: :request do
  let!(:published_key_stage) { create(:published_key_stage) }

  before do
    create(:key_stage)
  end

  describe 'parameter handling' do
    context 'with a keyStage query' do
      it 'returns the expected value when a slug is passed' do
        post '/graphql', params: {
          query: <<~GQL
            {
              keyStage(slug: "#{published_key_stage.slug}")
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
              id: published_key_stage.id,
              slug: published_key_stage.slug,
            }
          }
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
                message: "'nonsense' not found",
                locations: [
                    {
                        line: 2,
                        column: 3
                    }
                ],
                path: [
                    "keyStage"
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
