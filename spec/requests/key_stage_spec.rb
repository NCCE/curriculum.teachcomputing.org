require 'rails_helper'

RSpec.describe KeyStage, type: :request  do
	let(:key_stage) { create(:key_stage) }
	before do
  	key_stage
  end

  describe 'list Key Stages' do
    it 'returns key stages' do
			post '/graphql', params: { query: <<~GQL
																							{
																								keyStages
																									{
																									id
																									title
																									description
																									}
																							}
																				GQL
															}
			expect(response).to be_successful
			expected_response = "{\"data\":{\"keyStages\":[{\"id\":\"#{key_stage.id}\",\"title\":\"#{key_stage.title}\",\"description\":\"#{key_stage.description}\"}]}}"
			expect(response.body).to eq(expected_response)
    end
  end

end
