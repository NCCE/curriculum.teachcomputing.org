require "rails_helper"

RSpec.describe Video, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:units) }
    it { is_expected.to have_many(:lessons) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:video_url) }
  end

  describe "nullify association" do
    it "should nullify links when video is deleted" do
      video = create(:video)
      unit = create(:unit, title: "Unit 1", video:)
      video.destroy!
      unit.reload
      expect(unit.video).to be nil
    end
  end
end
