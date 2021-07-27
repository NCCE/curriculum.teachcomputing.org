require 'rails_helper'
require Rails.root.join 'spec/models/concerns/publishable_shared_examples.rb'
require Rails.root.join 'spec/models/concerns/rateable_shared_examples.rb'

RSpec.describe Unit, type: :model do
  include Rails.application.routes.url_helpers

  it_behaves_like 'publishable', %i[lessons]
  it_behaves_like 'rateable'

  describe 'associations' do
    it { is_expected.to belong_to(:year_group) }
    it { is_expected.to have_many(:lessons) }
    it { is_expected.to have_many(:aggregate_downloads) }
    it { is_expected.to have_and_belong_to_many(:national_curriculum_statements) }
    it { is_expected.to have_and_belong_to_many(:connected_world_strands) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe 'callbacks' do
    describe '#set_slug' do
      it 'sets the slug once saved' do
        unit = build(:unit)
        unit.run_callbacks :save
        expect(unit.slug).to eq unit.title.parameterize
      end
    end

    describe '#notify_update' do
      it 'runs the UpdateNotifier' do
        notifier_double = instance_double(UpdateNotifier)
        allow(notifier_double).to receive(:run)
        allow(UpdateNotifier).to receive(:new) { notifier_double }
        instance = build(:unit)
        instance.run_callbacks :commit
        expect(UpdateNotifier)
          .to have_received(:new)
          .once
          .with([instance, instance.year_group.key_stage])
        expect(notifier_double).to have_received(:run).once
      end
    end
  end

  describe '#unit_guide_url' do
    let(:unit) { create(:unit) }

    context 'when no attachment' do
      it 'returns nil' do
        expect(unit.unit_guide_url).to eq(nil)
      end
    end

    context 'when attachment present' do
      it 'returns url of attachment' do
        unit.unit_guide.attach(
          io: File.open('spec/support/test.txt'),
          filename: 'test.txt',
          content_type: 'text/plain'
        )

        expect(unit.unit_guide_url).to eq(url_for(unit.unit_guide))
      end
    end
  end

  describe '#learning_graphs_urls' do
    let(:unit) { create(:unit) }

    context 'when no attachment' do
      it 'returns empty array' do
        expect(unit.learning_graphs_urls).to eq([])
      end
    end

    context 'when attachment present' do
      it 'returns array of attachment urls' do
        unit.learning_graphs.attach(
          io: File.open('spec/support/test.txt'),
          filename: 'test.txt',
          content_type: 'text/plain'
        )

        unit.learning_graphs.attach(
          io: File.open('spec/support/test.txt'),
          filename: 'test2.txt',
          content_type: 'text/plain'
        )

        expect(unit.learning_graphs_urls)
          .to match_array(
            [
              url_for(unit.learning_graphs.first),
              url_for(unit.learning_graphs.last)
            ]
          )
      end
    end
  end

  describe '#rubrics_urls' do
    let(:unit) { create(:unit) }

    context 'when no attachment' do
      it 'returns empty array' do
        expect(unit.rubrics_urls).to eq([])
      end
    end

    context 'when attachment present' do
      it 'returns array of attachment urls' do
        unit.rubrics.attach(
          io: File.open('spec/support/test.txt'),
          filename: 'test.txt',
          content_type: 'text/plain'
        )

        unit.rubrics.attach(
          io: File.open('spec/support/test.txt'),
          filename: 'test2.txt',
          content_type: 'text/plain'
        )

        expect(unit.rubrics_urls)
          .to match_array(
            [
              url_for(unit.rubrics.first),
              url_for(unit.rubrics.last)
            ]
          )
      end
    end
  end

  describe '#summative_assessments_urls' do
    let(:unit) { create(:unit) }

    context 'when no attachment' do
      it 'returns empty array' do
        expect(unit.summative_assessments_urls).to eq([])
      end
    end

    context 'when attachment present' do
      it 'returns array of attachment urls' do
        unit.summative_assessments.attach(
          io: File.open('spec/support/test.txt'),
          filename: 'test.txt',
          content_type: 'text/plain'
        )

        unit.summative_assessments.attach(
          io: File.open('spec/support/test.txt'),
          filename: 'test2.txt',
          content_type: 'text/plain'
        )

        expect(unit.summative_assessments_urls)
          .to match_array(
            [
              url_for(unit.summative_assessments.first),
              url_for(unit.summative_assessments.last)
            ]
          )
      end
    end
  end

  describe '#summative_answers_urls' do
    let(:unit) { create(:unit) }

    context 'when no attachment' do
      it 'returns empty array' do
        expect(unit.summative_answers_urls).to eq([])
      end
    end

    context 'when attachment present' do
      it 'returns array of attachment urls' do
        unit.summative_answers.attach(
          io: File.open('spec/support/test.txt'),
          filename: 'test.txt',
          content_type: 'text/plain'
        )

        unit.summative_answers.attach(
          io: File.open('spec/support/test.txt'),
          filename: 'test2.txt',
          content_type: 'text/plain'
        )

        expect(unit.summative_answers_urls)
          .to match_array(
            [
              url_for(unit.summative_answers.first),
              url_for(unit.summative_answers.last)
            ]
          )
      end
    end
  end

  describe '#primary?' do
    it 'returns true if key stage is primary' do
      unit = build(:primary_unit)
      expect(unit.primary?).to eq(true)
    end

    it 'returns false if key stage is secondary' do
      unit = build(:secondary_unit)
      expect(unit.primary?).to eq(false)
    end
  end

  describe '#secondary?' do
    it 'returns false if key stage is primary' do
      unit = build(:primary_unit)
      expect(unit.secondary?).to eq(false)
    end

    it 'returns true if key stage is secondary' do
      unit = build(:secondary_unit)
      expect(unit.secondary?).to eq(true)
    end
  end
end
