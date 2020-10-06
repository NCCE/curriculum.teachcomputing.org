require 'rails_helper'
require Rails.root.join 'spec/models/concerns/publishable_shared_examples.rb'
require Rails.root.join 'spec/models/concerns/rateable_shared_examples.rb'

RSpec.describe Lesson, type: :model do
  let(:lesson) { create(:lesson) }

  it_behaves_like 'publishable'
  it_behaves_like 'rateable'

  describe 'associations' do
    it { is_expected.to belong_to(:unit) }
    it { is_expected.to have_many(:aggregate_downloads) }
  end

  describe 'validations' do
    before do
      lesson
    end

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_uniqueness_of(:slug).scoped_to(:unit_id) }
  end

  describe 'callbacks' do
    describe '#set_slug' do
      it 'sets the slug once saved' do
        lesson = build(:lesson)
        lesson.run_callbacks :save
        expect(lesson.slug).to eq lesson.title.parameterize
      end

      context 'when the lesson slug contains a number' do
        it 'sets the lesson_no once saved' do
          lesson = build(:lesson, title: 'Lesson 1')
          lesson.run_callbacks :save
          expect(lesson.lesson_no).to eq 1
        end
      end

      context 'when it does not include a number' do
        it 'sets the lesson_no once saved' do
          lesson = build(:lesson, title: 'Lesson example name')
          lesson.run_callbacks :save
          expect(lesson.lesson_no).to eq 0
        end
      end
    end

    describe '#notify_update' do
      it 'runs the UpdateNotifier' do
        notifier_double = instance_double(UpdateNotifier)
        allow(notifier_double).to receive(:run)
        allow(UpdateNotifier).to receive(:new) { notifier_double }
        instance = build(:lesson)
        instance.run_callbacks :commit
        expect(UpdateNotifier).to have_received(:new).once.with([instance.unit])
        expect(notifier_double).to have_received(:run).once
      end
    end
  end
end
