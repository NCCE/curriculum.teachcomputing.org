require 'rails_helper'

RSpec.describe UpdateNotifier do
  describe '#run' do
    context 'when resource is a Unit' do
      it 'queues InvalidateCacheWorker' do
        unit = create(:unit)
        expect { described_class.new(unit).run }.to change(InvalidateCacheWorker.jobs, :size).by(2)
      end

      it 'passes correct details to InvalidateCacheWorker' do
        unit = create(:unit)
        key_stage = unit.year_group.key_stage
        allow(InvalidateCacheWorker).to receive(:perform_async)
        described_class.new(unit).run
        expect(InvalidateCacheWorker)
          .to have_received(:perform_async)
          .with({ type: 'unit', identifier: unit.slug }).once
        expect(InvalidateCacheWorker)
          .to have_received(:perform_async)
          .with({ type: 'key_stage', identifier: key_stage.slug }).once
      end
    end

    context 'when resource is a KeyStage' do
      let(:key_stage) { build(:key_stage, slug: 'test-slug') }
      let(:notifier) { described_class.new(key_stage) }

      it 'queues InvalidateCacheWorker' do
        expect { notifier.run }.to change(InvalidateCacheWorker.jobs, :size).by(1)
      end

      it 'passes correct details to InvalidateCacheWorker' do
        allow(InvalidateCacheWorker).to receive(:perform_async)
        notifier.run
        expect(InvalidateCacheWorker)
          .to have_received(:perform_async)
          .with({ type: 'key_stage', identifier: 'test-slug' }).once
      end
    end
  end
end
