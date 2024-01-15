require "rails_helper"

RSpec.describe AggregateDownload, type: :model do
  let(:record_download) do
    described_class.increment_attachment_download(unit.unit_guide)
  end

  let(:unit) { create(:unit_with_guide) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:count) }
    it { is_expected.to validate_presence_of(:attachment_type) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:downloadable) }
    it { is_expected.to have_many(:downloads) }
  end

  describe ".increment_attachment_download" do
    context "when no aggregate_download record exists" do
      it "creates new aggregate_download record" do
        expect { record_download }
          .to change(described_class, :count).by(1)
      end

      it "sets aggregate_download count correctly" do
        record_download
        expect(described_class.count).to eq(1)
        expect(described_class.last.count).to eq(1)
      end

      it "creates new download record" do
        expect { record_download }
          .to change(Download, :count).by(1)
      end
    end

    context "when aggregate_download record exists" do
      it "does not create new record" do
        described_class.create(
          count: 1,
          downloadable: unit.unit_guide.record,
          attachment_type: unit.unit_guide.name
        )

        expect { record_download }
          .not_to change(described_class, :count)
      end

      it "updates aggregate_download count correctly" do
        download_record = described_class.create(
          count: 4,
          downloadable: unit.unit_guide.record,
          attachment_type: unit.unit_guide.name
        )

        record_download
        expect(download_record.reload.count).to eq(5)
      end

      it "creates new download record" do
        described_class.create(
          count: 4,
          downloadable: unit.unit_guide.record,
          attachment_type: unit.unit_guide.name
        )

        expect { record_download }
          .to change(Download, :count).by(1)
      end
    end

    context "when user_stem_achiever_contact_no is passed down" do
      it "has user_stem_achiever_contact_no set" do
        uuid = SecureRandom.uuid
        described_class.increment_attachment_download(unit.unit_guide, uuid.to_s)
        expect(Download.first.user_stem_achiever_contact_no).to eq uuid
      end
    end

    context "when user_stem_achiever_contact_no is not passed down" do
      it "has user_stem_achiever_contact_no set" do
        described_class.increment_attachment_download(unit.unit_guide)
        expect(Download.first.user_stem_achiever_contact_no).to eq nil
      end
    end
  end

  describe "downloadable models" do
    let(:key_stage_with_curriculum_maps) { create(:key_stage_with_curriculum_maps) }
    let(:curriculum_map) { key_stage_with_curriculum_maps.curriculum_maps.first }

    let(:increment_download_count) do
      described_class.increment_attachment_download(curriculum_map.file)
    end

    it "creates new aggregate_download record" do
      expect { increment_download_count }
        .to change(described_class, :count).by(1)
    end

    it "updates aggregate_download count correctly" do
      download_record = described_class.create(
        count: 4,
        downloadable: key_stage_with_curriculum_maps,
        attachment_type: :curriculum_map.to_s
      )

      increment_download_count
      expect(download_record.reload.count).to eq(5)
    end
  end
end
