require 'rails_helper'

RSpec.describe 'Accessing admin route', :type => :system do
  let(:user) { create(:user) }

  context 'when logged in' do
    before do
      sign_in user
    end

    it 'goes to the admin dashboard' do
      visit '/admin'
      expect(page).to have_text('Back to app')
    end
  end

  context 'when not logged in' do
    it 'goes to the log in page' do
      visit '/admin'
      expect(page).to have_text('Log in')
    end
  end
end
