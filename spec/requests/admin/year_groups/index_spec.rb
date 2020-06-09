require 'rails_helper'

RSpec.describe Admin::YearGroupsController do
  let(:key_stage) { create(:key_stage) }
  let(:year_groups) { create_list(:year_group, 3, key_stage: key_stage) }

  describe 'GET #index' do
    before do
      key_stage
      year_groups
      get admin_key_stage_year_groups_path(key_stage)
    end

    it 'assigns year_groups instance variable' do
      expect(assigns(:year_groups)).to eq year_groups
    end

    it 'redirects to the index template' do
      expect(response).to render_template(:index)
    end
  end
end
