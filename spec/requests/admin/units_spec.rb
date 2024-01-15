require "rails_helper"

RSpec.describe "Admin::UnitsController" do
  let(:unit) { create(:unit) }

  describe "GET #index" do
    before do
      get admin_units_path
    end

    it "renders the correct tempate" do
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before do
      get admin_unit_path(unit)
    end

    it "render the correct template" do
      expect(response).to render_template("show")
    end
  end
end
