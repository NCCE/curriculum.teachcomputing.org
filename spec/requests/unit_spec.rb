require 'rails_helper'

RSpec.describe Unit, type: :request  do
	let(:unit) { create(:unit) }
	before do
  	unit
  end

  describe 'list Units' do
    it 'returns units' do
			post '/graphql', params: { query: <<~GQL
																							{
																								units
																									{
																									id
																									title
																									description
																									}
																							}
																				GQL
															}
			expect(response).to be_successful
			expected_response = "{\"data\":{\"units\":[{\"id\":\"#{unit.id}\",\"title\":\"#{unit.title}\",\"description\":\"#{unit.description}\"}]}}"
			expect(response.body).to eq(expected_response)
    end
  end


end
