require 'spec_helper'

RSpec.shared_examples_for 'update_notifiable' do |klass|
  describe 'callbacks' do
    describe '#notify_update' do
      context 'when commit callback called' do
        it 'runs the UpdateNotifier' do
          notifier_double = instance_double(UpdateNotifier)
          allow(notifier_double).to receive(:run)
          allow(UpdateNotifier).to receive(:new) { notifier_double }
          instance = build(klass)
          instance.run_callbacks :commit
          expect(notifier_double).to have_received(:run).once
        end
      end
    end
  end
end
