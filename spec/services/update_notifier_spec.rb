require 'rails_helper'

RSpec.describe UpdateNotifier do
  describe '#run' do
    let(:key_stage) { build(:key_stage, slug: 'ks-slug') }
    let(:unit) { build(:unit, slug: 'unit-slug') }
    let(:lesson) { build(:lesson, slug: 'lesson-slug') }
    let(:published_lesson) { build(:lesson, slug: 'published-lesson-slug') }
    let(:redirect) { build(:redirect, from: 'lesson-slug', redirectable: published_lesson) }

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
      let(:notifier) { described_class.new([key_stage, unit, lesson, redirect], redirect: ['lesson-slug']) }

      it 'queues InvalidateCacheWorker for each resource' do
        expect { notifier.run }.to change(InvalidateCacheWorker.jobs, :size).by(4)
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
        expect(InvalidateCacheWorker)
          .to have_received(:perform_async)
          .with({ 'type' => 'redirect', 'identifier' => ['lesson-slug'] }).once
      end
    end
  end
end
