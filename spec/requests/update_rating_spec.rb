require 'rails_helper'

RSpec.describe 'Update rating', type: :request do
  let(:expected_rating) { create(:rating) }
  let(:user_stem_achiever_contact_no) { SecureRandom.uuid }
  let(:comment) { 'This is a commment' }
  let(:query) do
    { query: <<~GQL
      mutation {
        updateRating(
          id: "#{expected_rating.id}"
          comment: "#{comment}"
        )
        {
          id
          comment
        }
      }
    GQL
    }
  end

  it 'adds a comment' do
    expect(expected_rating.comment).to eq(nil)

    post '/graphql', params: query
    expect(response).to be_successful
    expect(response.body).to eq({
      data: {
        updateRating: {
          id: expected_rating.id,
          comment: comment
        }
      }
    }.to_json)
  end
end
