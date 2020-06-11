require 'rails_helper'

RSpec.describe Assessment, type: :request  do
	let(:assessment) { create(:assessment) }
	before do
  	assessment
  end

  describe 'list Assessments' do
    it 'returns assessments' do
			post '/graphql', params: { query: <<~GQL
																							{
																								assessments
																									{
																									id
																									title
																									description
																									}
																							}
																				GQL
															}
			expect(response).to be_successful
			expected_response = "{\"data\":{\"assessments\":[{\"id\":\"#{assessment.id}\",\"title\":\"#{assessment.title}\",\"description\":\"#{assessment.description}\"}]}}"
			expect(response.body).to eq(expected_response)
    end
  end

end
