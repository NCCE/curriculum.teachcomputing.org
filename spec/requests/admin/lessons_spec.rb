require 'rails_helper'

RSpec.describe 'Admin::LessonsController' do
  let(:lesson) { create(:lesson) }

  describe 'GET #index' do

    before do
      get admin_lessons_path
    end

    it 'renders the correct tempate' do
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do

    before do
      get admin_lesson_path(lesson)
    end

    it 'render the correct template' do
      expect(response).to render_template('show')
    end

  end

end
