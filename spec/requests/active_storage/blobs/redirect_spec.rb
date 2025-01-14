require "rails_helper"

RSpec.describe "Redirect", type: :request do
  let(:unit_with_attachment) { create(:published_unit) }

  before do
    get url_for(unit_with_attachment.unit_guide.attachment)
  end

  it "should redirect to blob url" do
    expect(response.status).to eq(302)
  end
end
