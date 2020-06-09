require 'rails_helper'

RSpec.describe Admin::KeyStagesController do
  let(:key_stage) { create(:key_stage) }
  let(:year_groups) { create_list(:year_group, 3, key_stage: key_stage) }

  describe 'GET #show' do
    before do
      key_stage
    end

    it 'assigns key_stage instance variable' do
      get admin_key_stage_path(key_stage)
      expect(assigns(:key_stage)).to eq key_stage
    end

    it 'redirects to the show template' do
      get admin_key_stage_path(key_stage)
      expect(response).to render_template(:show)
    end

    context 'when a KeyStage has YearGroups' do
      before do
        year_groups
      end

      it 'assigns year_groups instance variable' do
        get admin_key_stage_path(key_stage)
        expect(assigns(:year_groups)).to eq year_groups
      end
    end
  end
end
