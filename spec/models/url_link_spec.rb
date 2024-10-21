require "rails_helper"

RSpec.describe UrlLink, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:unit) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:label) }
    it { is_expected.to validate_presence_of(:url) }
  end
end
