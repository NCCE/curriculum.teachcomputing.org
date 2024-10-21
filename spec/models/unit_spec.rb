require "rails_helper"
require Rails.root.join "spec/models/concerns/publishable_shared_examples.rb"
require Rails.root.join "spec/models/concerns/rateable_shared_examples.rb"
require Rails.root.join "spec/models/concerns/redirectable_shared_examples.rb"

RSpec.describe Unit, type: :model do
  include Rails.application.routes.url_helpers

  it_behaves_like "publishable", %i[lessons]
  it_behaves_like "rateable"
  it_behaves_like "redirectable", described_class

  describe "associations" do
    it { is_expected.to belong_to(:year_group) }
    it { is_expected.to have_many(:lessons) }
    it { is_expected.to have_many(:aggregate_downloads) }
    it { is_expected.to have_many(:url_links) }
    it { is_expected.to have_and_belong_to_many(:national_curriculum_statements) }
    it { is_expected.to have_and_belong_to_many(:connected_world_strands) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }

    it "fail if the slug is not unique (to the key stage)" do
      year_group = create(:primary_year_group)
      create(:unit, title: "Unit 1", year_group: year_group)
      unit2 = build(:unit, title: "Unit 1", year_group: year_group)
      expect(unit2.valid?).to eq(false)
    end

    it "pass if the slug is unique (to the key stage)" do
      create(:primary_unit, title: "Unit 1")
      unit2 = build(:secondary_unit, title: "A random unit name")
      expect(unit2.valid?).to eq(true)
    end
  end

  describe "callbacks" do
    describe "#set_slug" do
      it "sets the slug on before_create" do
        unit = build(:unit)
        unit.run_callbacks :create
        expect(unit.slug).to eq unit.title.parameterize
      end
    end

    describe "#set_slug" do
      let(:unit) { create(:unit, title: "Test") }

      it "does not set the slug on update" do
        unit.update(title: "Test edited")
        expect(unit.slug).to eq "test"
      end
    end

    describe "#notify_update" do
      it "runs the UpdateNotifier" do
        notifier_double = instance_double(UpdateNotifier)
        allow(notifier_double).to receive(:run)
        allow(UpdateNotifier).to receive(:new) { notifier_double }
        instance = build(:unit)
        instance.run_callbacks :commit
        expect(UpdateNotifier)
          .to have_received(:new)
          .once
          .with([instance, instance.year_group, instance.year_group.key_stage], {unit: "-"})
        expect(notifier_double).to have_received(:run).once
      end
    end
  end

  describe "#primary?" do
    it "returns true if key stage is primary" do
      unit = build(:primary_unit)
      expect(unit.primary?).to eq(true)
    end

    it "returns false if key stage is secondary" do
      unit = build(:secondary_unit)
      expect(unit.primary?).to eq(false)
    end
  end

  describe "#secondary?" do
    it "returns false if key stage is primary" do
      unit = build(:primary_unit)
      expect(unit.secondary?).to eq(false)
    end

    it "returns true if key stage is secondary" do
      unit = build(:secondary_unit)
      expect(unit.secondary?).to eq(true)
    end
  end
end
