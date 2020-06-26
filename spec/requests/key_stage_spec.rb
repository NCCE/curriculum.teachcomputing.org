require 'rails_helper'

RSpec.describe 'KeyStage', type: :request do
  let!(:published_key_stage) { create(:published_key_stage) }

  before do
    create(:key_stage)
  end

  describe 'list Key Stages' do
    it 'returns published key stages' do
      post '/graphql', params: {
        query: <<~GQL
          {
            keyStages
              {
                id
                ksNumber
                description
              }
          }
        GQL
      }
      expect(response).to be_successful

      expected_response = {
        data: {
          keyStages: [{
            id: published_key_stage.id,
            ksNumber: published_key_stage.ks_number,
            description: published_key_stage.description
          }]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end
end
