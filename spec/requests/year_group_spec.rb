require 'rails_helper'

RSpec.describe YearGroup, type: :request  do
	before do
  	create(:year_group, id: 1, title: 'Title of the Year Group', description: 'Desc of the Year Group')
  end

  describe 'list Year Groupes' do
    it 'returns year groups' do
			post '/graphql', params: { query: <<~GQL
																							{
																								yearGroups
																									{id
																									title
																									description
																									}
																							}
																				GQL
															}
			expect(response).to be_successful
			expected_response = "{\"data\":{\"yearGroups\":[{\"id\":\"1\",\"title\":\"Title of the Year Group\",\"description\":\"Desc of the Year Group\"}]}}"
			expect(response.body).to eq(expected_response)
    end
  end

end
