require 'rails_helper'

RSpec.describe Admin::KeyStagesController do
  let(:key_stages) { create_list(:key_stage, 6) }

  describe 'GET #index' do
    before do
      key_stages
      get admin_key_stages_path
    end

    it 'assigns key_stages instance variable' do
      expect(assigns(:key_stages)).to eq key_stages
    end

    it 'redirects to the index template' do
      expect(response).to render_template(:index)
    end
  end
end
