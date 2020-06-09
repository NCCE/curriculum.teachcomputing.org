require 'rails_helper'

RSpec.describe Admin::KeyStagesController do
  let(:key_stage) { create(:key_stage) }

  describe 'GET #show' do
    before do
      key_stage
      get admin_key_stage_path(key_stage)
    end

    it 'assigns key_stage instance variable' do
      expect(assigns(:key_stage)).to eq key_stage
    end

    it 'redirects to the show template' do
      expect(response).to render_template(:show)
    end
  end
end
