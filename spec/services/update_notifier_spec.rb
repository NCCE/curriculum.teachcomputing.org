require 'rails_helper'

RSpec.describe UpdateNotifier do
  describe '#run' do
    it 'queues job for unit resource' do
      unit = create(:unit)
      notifier = described_class.new(unit)
      expect(notifier.run).to eq(true)
    end
  end
end
