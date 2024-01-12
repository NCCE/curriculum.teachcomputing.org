require "rails_helper"

RSpec.describe "Redirect", type: :request do
  describe "list redirects" do
    let!(:published_lesson) { create(:lesson, state: create(:published_state)) }
    let(:unit) { create(:unit) }
    let!(:unpublished_lesson) { create(:lesson, state: create(:state), unit_id: unit.id) }
    let!(:unpublished_lesson_2) { create(:lesson, title: "Another lesson", state: create(:state), unit_id: unit.id) }
    let!(:redirect) { create(:redirect, from: "some_unit,some_where", redirectable: published_lesson) }
    let!(:redirect_2) { create(:redirect, from: "some_where_else,some_other_unit", redirectable: published_lesson) }

    it "returns all redirects" do
      post "/graphql", params: {
        query: <<~GQL
          {
            redirects
              {
                from
                to
              }
          }
        GQL
      }
      expect(response).to be_successful

      expected_response = {
        data: {
          redirects: [
            {from: redirect.from, to: redirect.to},
            {from: redirect_2.from, to: redirect_2.to}
          ]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end

    it "only returns the redirects for the specified slug" do
      post "/graphql", params: {
        query: <<~GQL
          {
            redirect(from: "some_where", fromContext: "some_unit") {
              from
              fromContext
              to
            }
          }
        GQL
      }
      expect(response).to be_successful

      expected_response = {
        data: {
          redirect: {from: redirect.from, fromContext: "some_unit", to: redirect.to}
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end
end
