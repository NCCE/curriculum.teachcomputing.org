require 'rails_helper'

RSpec.describe 'Admin::KeyStagesController' do

  let(:key_stage) { create(:key_stage) }

  describe 'GET #index' do

    before do
      get admin_key_stages_path
    end

    it 'renders the correct tempate' do
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do

    before do
      get admin_key_stage_path(key_stage)
    end

    it 'render the correct template' do
      expect(response).to render_template('show')
    end

  end
end
