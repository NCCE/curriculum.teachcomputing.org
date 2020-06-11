require 'rails_helper'

RSpec.describe YearGroup, type: :request  do
	let(:year_group) { create(:year_group) }
	before do
  	year_group
  end

  describe 'list Year Groupes' do
    it 'returns year groups' do
			post '/graphql', params: { query: <<~GQL
																							{
																								yearGroups
																									{
																									id
																									title
																									description
																									}
																							}
																				GQL
															}
			expect(response).to be_successful
			expected_response = "{\"data\":{\"yearGroups\":[{\"id\":\"#{year_group.id}\",\"title\":\"#{year_group.title}\",\"description\":\"#{year_group.description}\"}]}}"
			expect(response.body).to eq(expected_response)
    end
  end

end
