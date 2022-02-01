require 'rails_helper'

RSpec.describe UpdateNotifier do
  describe '#run' do
    let(:key_stage) { build(:key_stage, slug: 'ks-slug') }
    let(:unit) { build(:unit, slug: 'unit-slug') }
    let(:lesson) { build(:lesson, slug: 'lesson-slug') }

    context 'when one resource passed' do
      let(:notifier) { described_class.new([unit]) }

      it 'queues InvalidateCacheWorker for each resource' do
        expect { notifier.run }.to change(InvalidateCacheWorker.jobs, :size).by(1)
      end

      it 'passes correct details to InvalidateCacheWorker' do
        allow(InvalidateCacheWorker).to receive(:perform_async)
        notifier.run
        expect(InvalidateCacheWorker)
          .to have_received(:perform_async)
          .with({ 'type' => 'unit', 'identifier' => 'unit-slug' }).once
      end
    end

    context 'when multiple resources passed' do
      let(:notifier) { described_class.new([key_stage, unit, lesson]) }

      it 'queues InvalidateCacheWorker for each resource' do
        expect { notifier.run }.to change(InvalidateCacheWorker.jobs, :size).by(3)
      end

      it 'passes correct details to InvalidateCacheWorker' do
        allow(InvalidateCacheWorker).to receive(:perform_async)
        notifier.run
        expect(InvalidateCacheWorker)
          .to have_received(:perform_async)
          .with({ 'type' => 'key_stage', 'identifier' => 'ks-slug' }).once
        expect(InvalidateCacheWorker)
          .to have_received(:perform_async)
          .with({ 'type' => 'unit', 'identifier' => 'unit-slug' }).once
        expect(InvalidateCacheWorker)
          .to have_received(:perform_async)
          .with({ 'type' => 'lesson', 'identifier' => 'lesson-slug' }).once
      end
    end
  end
end
