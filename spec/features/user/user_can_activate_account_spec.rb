require 'rails_helper'

feature 'As a non-activated, logged-in user' do
  context 'when it visits /dashboard' do
    it 'shows user status' do
      user = create(:user)
      login_as(user)

      expect(page).to have_content("Status: Inactive")
    end
  end
end
