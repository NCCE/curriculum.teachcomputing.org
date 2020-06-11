require 'rails_helper'

RSpec.describe Assessment, type: :request  do
	before do
  	create(:assessment, id: 'b9592bb3-cdde-4023-be9e-a56ef088971f', title: 'Title of the Assessment', description: 'Desc of the Assessment')
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
			expected_response = "{\"data\":{\"assessments\":[{\"id\":\"b9592bb3-cdde-4023-be9e-a56ef088971f\",\"title\":\"Title of the Assessment\",\"description\":\"Desc of the Assessment\"}]}}"
			expect(response.body).to eq(expected_response)
    end
  end

end
