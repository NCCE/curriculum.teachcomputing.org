require 'spec_helper'

shared_examples_for 'administrate publishable' do |model|
  it 'allows publishing of unpublished key stage' do
    instance = create(model)
    expect(instance.published?).to eq(false)
    visit "/admin/#{model}s/#{instance.id}"
    click_button 'Publish'

    expect(page).to have_text("#{model.to_s.classify} was successfully published.")
    expect(instance.reload.published?).to eq(true)
  end

  it 'allows unpublishing of published key stage' do
    published_state = create(:published_state)
    instance = create(model, state: published_state)
    expect(instance.published?).to eq(true)
    visit "/admin/#{model}s/#{instance.id}"
    click_button 'Unpublish'

    expect(page).to have_text("#{model.to_s.classify} was successfully unpublished.")
    expect(instance.reload.published?).to eq(false)
  end
end
