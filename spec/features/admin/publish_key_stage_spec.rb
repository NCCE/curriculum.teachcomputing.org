require 'rails_helper'

RSpec.describe 'Publish state management', type: :system do
  it 'allows publishing of unpublished key stage' do
    key_stage = create(:key_stage)
    expect(key_stage.published?).to eq(false)
    visit "/admin/key_stages/#{key_stage.id}"
    click_button 'Publish'

    expect(page).to have_text('KeyStage was successfully published.')
    expect(key_stage.reload.published?).to eq(true)
  end

  it 'allows unpublishing of published key stage' do
    key_stage = create(:published_key_stage)
    expect(key_stage.published?).to eq(true)
    visit "/admin/key_stages/#{key_stage.id}"
    click_button 'Unpublish'

    expect(page).to have_text('KeyStage was successfully unpublished.')
    expect(key_stage.reload.published?).to eq(false)
  end
end
