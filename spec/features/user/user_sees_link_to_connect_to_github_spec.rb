require 'rails_helper'

feature 'as a user' do
  context 'when I visit my dashboard' do
    it 'sees a link to connect to GitHub' do
      user = create(:user)

      login_as(user)

      expect(page).to have_link('Connect to GitHub')
    end
  end
end
