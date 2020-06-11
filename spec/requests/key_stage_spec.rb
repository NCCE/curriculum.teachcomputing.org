require 'rails_helper'

RSpec.describe KeyStage, type: :request  do
	before do
  	create(:key_stage, id: 1, title: 'Title of the Key Stage', description: 'Desc of the Key Stage')
  	create(:year_group, id: 1, title: 'Title of the Lesson', description: 'Desc of the Year Group')
  	create(:unit, id: 1, title: 'Title of the Unit', description: 'Desc of the Unit')
  	create(:lesson, id: 1, title: 'Title of the Lesson', description: 'Desc of the Lesson')
  	create(:assessment, id: 1, title: 'Title of the Assessment', description: 'Desc of the Assessment')
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

  describe 'list Lessons' do
    it 'returns lessons' do
			post '/graphql', params: { query: <<~GQL
																							{
																								lessons
																									{id
																									title
																									description
																									}
																							}
																				GQL
															}
			expect(response).to be_successful
			expected_response = "{\"data\":{\"lessons\":[{\"id\":\"1\",\"title\":\"Title of the Lesson\",\"description\":\"Desc of the Lesson\"}]}}"
			expect(response.body).to eq(expected_response)
    end
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
			expected_response = "{\"data\":{\"units\":[{\"id\":\"1\",\"title\":\"Title of the Unit\",\"description\":\"Desc of the Unit\"}]}}"
			expect(response.body).to eq(expected_response)
    end
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
