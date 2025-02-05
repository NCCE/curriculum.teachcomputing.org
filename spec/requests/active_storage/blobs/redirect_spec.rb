require "rails_helper"

RSpec.describe "Redirect", type: :request do
  let(:unit_with_attachment) { create(:published_unit) }
  let(:user_stem_achiever_contact_no) { SecureRandom.uuid }

  it "should redirect to blob url" do
    get url_for(unit_with_attachment.unit_guide.attachment)
    expect(response.status).to eq(302)
  end

  it "should call AggregateDownload" do
    expect(AggregateDownload).to receive(:increment_attachment_download)
      .with(unit_with_attachment.unit_guide.attachment, user_stem_achiever_contact_no)
    get url_for(unit_with_attachment.unit_guide.attachment), params: {user_stem_achiever_contact_no:}
  end
end
