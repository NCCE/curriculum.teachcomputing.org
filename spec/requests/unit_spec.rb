require 'rails_helper'

RSpec.describe Unit, type: :request  do
	before do
  	create(:unit, id: '072d2415-8f04-4a65-9d50-ba4a2bbd62a7', title: 'Title of the Unit', description: 'Desc of the Unit')
  end

  describe 'list Units' do
    it 'returns units' do
			post '/graphql', params: { query: <<~GQL
																							{
																								units
																									{id
																									title
																									description
																									}
																							}
																				GQL
															}
			expect(response).to be_successful
			expected_response = "{\"data\":{\"units\":[{\"id\":\"072d2415-8f04-4a65-9d50-ba4a2bbd62a7\",\"title\":\"Title of the Unit\",\"description\":\"Desc of the Unit\"}]}}"
			expect(response.body).to eq(expected_response)
    end
  end


end
