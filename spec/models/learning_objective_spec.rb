require 'rails_helper'

RSpec.describe LearningObjective, type: :model do
  it { is_expected.to have_and_belong_to_many(:taxonomy_tags) }
  it { is_expected.to have_many(:success_criteria) }
  it { is_expected.to belong_to(:lesson) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_numericality_of(:order).is_greater_than(0) }

  describe 'validating success criteria' do
    context 'when lesson is primary' do
      let(:lesson) { build(:primary_lesson) }

      it 'is invalid if no success criteria' do
        objective = build(:learning_objective, lesson: lesson)
        expect(objective.valid?).to eq(false)
        expect(objective.errors.messages[:success_criteria])
          .to eq(['must be included for learning objectives on primary lessons'])
      end

      it 'is valid if success criteria present' do
        objective = build(:learning_objective, lesson: lesson)
        objective.success_criteria = [build(:success_criterion, learning_objective: objective)]

        expect(objective.valid?).to eq(true)
        expect(objective.errors.messages).to eq({})
      end
    end

    context 'when lesson is secondary' do
      let(:lesson) { build(:secondary_lesson) }

      it 'is valid if no success criteria' do
        objective = build(:learning_objective, lesson: lesson)
        expect(objective.valid?).to eq(true)
        expect(objective.errors.messages).to eq({})
      end

      it 'is invalid if success criteria present' do
        objective = build(:learning_objective, lesson: lesson, success_criteria: [build(:success_criterion)])
        expect(objective.valid?).to eq(false)
        expect(objective.errors.messages[:success_criteria])
          .to eq(['are not needed on secondary lessons'])
      end
    end
  end
end
