require 'rails_helper'

RSpec.describe Lesson, type: :request  do
	before do
  	create(:lesson, id: id, title: 'Title of the Lesson', description: 'Desc of the Lesson')
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
			expected_response = "{\"data\":{\"lessons\":[{\"id\":\"id\",\"title\":\"Title of the Lesson\",\"description\":\"Desc of the Lesson\"}]}}"
			expect(response.body).to eq(expected_response)
    end
  end

end
