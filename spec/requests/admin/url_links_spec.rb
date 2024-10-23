require "rails_helper"

RSpec.describe "Admin::UrlLinksController" do
  let(:url_link) { create(:url_link) }

  describe "GET #index" do
    before do
      get admin_url_links_path
    end

    it "renders the correct tempate" do
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before do
      get admin_url_link_path(url_link)
    end

    it "render the correct template" do
      expect(response).to render_template("show")
    end
  end
end
