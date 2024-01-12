require "rails_helper"

RSpec.describe "YearGroup", type: :request do
  let!(:published_year_group) { create(:published_year_group) }

  before do
    create(:year_group)
  end

  describe "list Year Groups" do
    it "returns published year groups" do
      post "/graphql", params: {
        query: <<~GQL
          {
            yearGroups
              {
                id
                keyStage {
                  id
                }
                yearNumber
                units {
                  id
                  title
                }
              }
          }
        GQL
      }
      expect(response).to be_successful

      expected_response = {
        data: {
          yearGroups: [{
            id: published_year_group.id,
            keyStage: {
              id: published_year_group.key_stage.id
            },
            yearNumber: published_year_group.year_number,
            units: []
          }]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end

    it "only returns published units" do
      published_unit = create(:published_unit, title: "Published Unit",
        year_group: published_year_group)
      create(:unit, year_group: published_year_group)
      post "/graphql", params: {
        query: <<~GQL
          {
            yearGroups
              {
                id
                slug
                keyStage {
                  id
                }
                yearNumber
                units {
                  id
                  title
                }
              }
          }
        GQL
      }
      expect(response).to be_successful

      expected_response = {
        data: {
          yearGroups: [{
            id: published_year_group.id,
            slug: published_year_group.slug,
            keyStage: {
              id: published_year_group.key_stage.id
            },
            yearNumber: published_year_group.year_number,
            units: [{
              id: published_unit.id,
              title: published_unit.title
            }]
          }]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end
end
