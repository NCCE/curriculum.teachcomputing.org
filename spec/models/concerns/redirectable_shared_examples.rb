require 'spec_helper'

RSpec.shared_examples_for 'redirectable' do |_associated|
  let(:unpublished_state) { create(:state) }
  let(:published_state) { create(:published_state) }

  describe 'associations' do
    it { is_expected.to have_many(:redirects) }
  end
end
