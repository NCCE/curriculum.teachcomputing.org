require 'rails_helper'

RSpec.describe Redirect, type: :model do
  let(:unpublished_state) { create(:state) }
  let(:published_state) { create(:published_state) }

  it { is_expected.to belong_to(:redirectable) }

  context 'with a lesson' do
    it 'assigns the to field on create' do
      unpublished_lesson = create(:lesson, title: 'Some lesson', state: unpublished_state)
      published_lesson = create(:lesson, title: 'Some other lesson', state: published_state)
      redirect = create(:redirect, from: unpublished_lesson.slug, redirectable: published_lesson)

      expect(redirect.to).to eq('some-other-lesson')
    end
  end

  context 'with a unit' do
    it 'assigns the to field on create' do
      unpublished_unit = create(:unit, title: 'Some unit', state: unpublished_state)
      published_unit = create(:unit, title: 'Some other unit', state: published_state)
      redirect = create(:redirect, from: unpublished_unit.slug, redirectable: published_unit)

      expect(redirect.to).to eq('some-other-unit')
    end
  end

  describe 'validations' do
    context 'with to field' do
      it 'rejects an unpublished unit' do
        published_unit = create(:unit, title: 'Some unit', state: published_state)
        unpublished_unit = create(:unit, title: 'Some unit', state: unpublished_state)
        redirect = build(:redirect, from: published_unit.slug, redirectable: unpublished_unit)
        redirect.validate
        expect(redirect.errors.messages[:to]).to eq(['must be published'])
      end
    end

    context 'with a lesson' do
      it 'validates' do
        unpublished_lesson = create(:lesson, title: 'Some lesson', state: unpublished_state)
        published_lesson = create(:lesson, title: 'Some other lesson', state: published_state)
        redirect = build(:redirect, from: unpublished_lesson.slug, redirectable: published_lesson)
        redirect.validate
        expect(redirect.valid?).to eq(true)
      end
    end

    context 'with a unit' do
      it 'validates' do
        unpublished_unit = create(:unit, title: 'Some unit', state: unpublished_state)
        published_unit = create(:unit, title: 'Some other unit', state: published_state)
        redirect = build(:redirect, from: unpublished_unit.slug, redirectable: published_unit)
        redirect.validate
        expect(redirect.valid?).to eq(true)
      end
    end

    context 'with an existing redirect' do
      let!(:unpublished_unit) { create(:unit, title: 'Some unit', state: unpublished_state) }

      before do
        published_unit = create(:unit, title: 'Some other unit', state: published_state)
        create(:redirect, from: unpublished_unit.slug, redirectable: published_unit)
      end

      # TODO: Reinstate
      # it 'rejects an attempt reuse the resource' do
      #   published_unit = create(:unit, title: 'Yet another unit', state: published_state)
      #   redirect = build(:redirect, from: unpublished_unit.slug, redirectable: published_unit)
      #   redirect.validate
      #   expect(redirect.errors.messages[:from]).to eq(['already has a redirect defined for it'])
      # end
    end
  end
end
