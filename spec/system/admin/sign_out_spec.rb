require 'rails_helper'

RSpec.describe 'Sign out of admin dasboard', :type => :system do
  let(:user) { create(:user) }

  context 'when logged in' do
    before do
      sign_in user
    end

    it 'goes to the admin dashboard' do
      visit '/admin'
      click_link 'Sign out'
      expect(page).to have_text('Log in')
    end
  end
end
