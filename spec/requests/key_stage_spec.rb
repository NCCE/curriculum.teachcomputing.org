require 'rails_helper'

RSpec.describe KeyStage, type: :request  do
	before do
  	create(:key_stage, id: 1, title: 'Title of the Key Stage', description: 'Desc of the Key Stage')
  end

  describe 'list Key Stages' do
    it 'returns key stages' do
			post '/graphql', params: { query: <<~GQL
																							{
																								keyStages
																									{id
																									title
																									description
																									}
																							}
																				GQL
															}
			expect(response).to be_successful
			expected_response = "{\"data\":{\"keyStages\":[{\"id\":\"1\",\"title\":\"Title of the Key Stage\",\"description\":\"Desc of the Key Stage\"}]}}"
			expect(response.body).to eq(expected_response)
    end
  end

end
