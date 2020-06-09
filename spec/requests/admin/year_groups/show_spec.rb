require 'rails_helper'

RSpec.describe Admin::KeyStagesController do
  let(:key_stage) { create(:key_stage) }
  let(:year_group) { create(:year_group, key_stage: key_stage) }

  describe 'GET #show' do
    before do
      key_stage
      year_group
    end

    it 'assigns year_group instance variable' do
      get admin_key_stage_year_group_path(key_stage, year_group)
      expect(assigns(:year_group)).to eq year_group
    end

    it 'redirects to the show template' do
      get admin_key_stage_year_group_path(key_stage, year_group)
      expect(response).to render_template(:show)
    end
  end
end
