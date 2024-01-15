require "rails_helper"

RSpec.describe "Admin::YearGroupsController" do
  let(:year_group) { create(:year_group) }

  describe "GET #index" do
    before do
      get admin_year_groups_path
    end

    it "renders the correct tempate" do
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before do
      get admin_year_group_path(year_group)
    end

    it "render the correct template" do
      expect(response).to render_template("show")
    end
  end
end
