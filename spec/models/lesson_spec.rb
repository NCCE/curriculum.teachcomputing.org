require 'rails_helper'
require Rails.root.join 'spec/models/concerns/publishable_shared_examples.rb'
require Rails.root.join 'spec/models/concerns/rateable_shared_examples.rb'
require Rails.root.join 'spec/models/concerns/redirectable_shared_examples.rb'

RSpec.describe Lesson, type: :model do
  let(:lesson) { create(:lesson) }

  it_behaves_like 'publishable'
  it_behaves_like 'rateable'
  it_behaves_like 'redirectable', described_class

  describe 'associations' do
    it { is_expected.to belong_to(:unit) }
    it { is_expected.to have_many(:aggregate_downloads) }
    it { is_expected.to have_many(:learning_objectives) }
  end

  describe 'validations' do
    before do
      lesson
    end

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_uniqueness_of(:slug).scoped_to(:unit_id) }
  end

  describe 'validating learning objectives' do
    it 'does nothing when no learning objectives are present' do
      lesson = build(:lesson)
      expect(lesson.valid?).to eq(true)
    end

    context 'when primary' do
      it 'is valid if one valid learning objective present' do
        lesson = build(:primary_lesson)
        learning_objective = build(:primary_learning_objective, lesson: lesson)
        success_criterion = build(:success_criterion, learning_objective: learning_objective)
        lesson.learning_objectives = [build(:primary_learning_objective, lesson: lesson,
                                                                         success_criteria: [success_criterion])]

        expect(lesson.valid?).to eq(true)
      end

      it 'is invalid if more than one learning objective' do
        lesson = build(:primary_lesson, learning_objectives: build_list(:learning_objective, 2))
        expect(lesson.valid?).to eq(false)
      end

      it 'adds error message if more than 1 learning objective' do
        lesson = build(:primary_lesson, learning_objectives: build_list(:learning_objective, 2))
        lesson.valid?
        expect(lesson.errors.messages[:learning_objectives]).not_to be(nil)
      end
    end
  end

  describe 'callbacks' do
    describe '#set_slug on create' do
      it 'sets the slug' do
        lesson = build(:lesson)
        lesson.run_callbacks :create
        expect(lesson.slug).to eq lesson.title.parameterize
      end
    end

    describe '#set_slug on update' do
      let(:lesson) { create(:lesson, title: 'Test') }

      it 'does not set the slug' do
        lesson.update(title: 'Test edited')
        expect(lesson.slug).to eq 'test'
      end
    end

    describe '#notify_update' do
      it 'runs the UpdateNotifier' do
        notifier_double = instance_double(UpdateNotifier)
        allow(notifier_double).to receive(:run)
        allow(UpdateNotifier).to receive(:new) { notifier_double }
        unit_instance = build(:unit)
        lesson_instance = build(:lesson, unit: unit_instance)
        lesson_instance.run_callbacks :commit
        # the second param `-` is an overriden cache identifier
        expect(UpdateNotifier).to have_received(:new).once.with([lesson_instance, unit_instance], unit: '-', lesson: '-')
        expect(notifier_double).to have_received(:run).once
      end
    end
  end

  describe '#primary?' do
    it 'returns true when key stage is primary' do
      lesson = build(:primary_lesson)
      expect(lesson.primary?).to eq(true)
    end

    it 'returns false when key stage is secondary' do
      lesson = build(:secondary_lesson)
      expect(lesson.primary?).to eq(false)
    end
  end

  describe '#secondary?' do
    it 'returns false when key stage is primary' do
      lesson = build(:primary_lesson)
      expect(lesson.secondary?).to eq(false)
    end

    it 'returns true when key stage is secondary' do
      lesson = build(:secondary_lesson)
      expect(lesson.secondary?).to eq(true)
    end
  end
end
