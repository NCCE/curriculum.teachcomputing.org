require "rails_helper"

RSpec.describe "Admin::VideosController" do
  let(:video) { create(:video) }

  describe "GET #index" do
    before do
      get admin_videos_path
    end

    it "renders the correct tempate" do
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before do
      get admin_video_path(video)
    end

    it "render the correct template" do
      expect(response).to render_template("show")
    end
  end
end
