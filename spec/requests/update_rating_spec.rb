require "rails_helper"

RSpec.describe "Update rating", type: :request do
  let(:expected_rating) { create(:rating) }
  let(:user_stem_achiever_contact_no) { SecureRandom.uuid }
  let(:comment) { "This is a commment" }
  let(:choices) { "['first choice', 'second choice', 'third choice']" }
  let(:query) do
    {query: <<~GQL
      mutation {
        updateRating(
          id: "#{expected_rating.id}"
          comment: "#{comment}"
        )
        {
          id
          comment
          choices
        }
      }
    GQL
    }
  end

  let(:query_2) do
    {query: <<~GQL
      mutation {
        updateRating(
          id: "#{expected_rating.id}"
          choices: "#{choices}"
        )
        {
          id
          comment
          choices
        }
      }
    GQL
    }
  end

  let(:query_3) do
    {query: <<~GQL
      mutation {
        updateRating(
          id: "#{expected_rating.id}"
          comment: "#{comment}"
          choices: "#{choices}"
        )
        {
          id
          comment
          choices
        }
      }
    GQL
    }
  end

  it "updates just a comment" do
    expect(expected_rating.comment).to eq(nil)
    expect(expected_rating.choices).to eq(nil)
    post "/graphql", params: query
    expect(response).to be_successful
    expect(response.body).to eq({
      data: {
        updateRating: {
          id: expected_rating.id,
          comment: "This is a commment",
          choices: nil
        }
      }
    }.to_json)
  end

  it "updates just choices" do
    expect(expected_rating.choices).to eq(nil)
    expect(expected_rating.comment).to eq(nil)
    post "/graphql", params: query_2
    expect(response).to be_successful
    expect(response.body).to eq({
      data: {
        updateRating: {
          id: expected_rating.id,
          comment: nil,
          choices: [choices]
        }
      }
    }.to_json)
  end

  it "updates both choices and comment" do
    expect(expected_rating.choices).to eq(nil)
    expect(expected_rating.comment).to eq(nil)
    post "/graphql", params: query_3
    expect(response).to be_successful
    expect(response.body).to eq({
      data: {
        updateRating: {
          id: expected_rating.id,
          comment: "This is a commment",
          choices: [choices]
        }
      }
    }.to_json)
  end
end
