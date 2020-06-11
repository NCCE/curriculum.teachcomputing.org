require 'rails_helper'

RSpec.describe Lesson, type: :request  do
	let(:lesson) { create(:lesson) }
	before do
  	lesson
  end

  describe 'list Lessons' do
    it 'returns lessons' do
			post '/graphql', params: { query: <<~GQL
																							{
																								lessons
																									{
																									id
																									title
																									description
																									}
																							}
																				GQL
															}
			expect(response).to be_successful
			expected_response = "{\"data\":{\"lessons\":[{\"id\":\"#{lesson.id}\",\"title\":\"#{lesson.title}\",\"description\":\"#{lesson.description}\"}]}}"
			expect(response.body).to eq(expected_response)
    end
  end

end
