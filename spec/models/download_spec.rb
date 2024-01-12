require "rails_helper"

RSpec.describe Download, type: :model do
  it { is_expected.to belong_to(:aggregate_download) }
end
