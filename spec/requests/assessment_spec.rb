require 'rails_helper'

RSpec.describe Assessment, type: :request  do
	before do
  	create(:assessment, id: 1, title: 'Title of the Assessment', description: 'Desc of the Assessment')
  end

  describe 'list Assessments' do
    it 'returns assessments' do
			post '/graphql', params: { query: <<~GQL
																							{
																								assessments
																									{id
																									title
																									description
																									}
																							}
																				GQL
															}
			expect(response).to be_successful
			expected_response = "{\"data\":{\"assessments\":[{\"id\":\"1\",\"title\":\"Title of the Assessment\",\"description\":\"Desc of the Assessment\"}]}}"
			expect(response.body).to eq(expected_response)
    end
  end

end
