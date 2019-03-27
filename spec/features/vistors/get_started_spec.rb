require 'rails_helper'

feature 'as a visitor' do
  context 'when visiting the /get_started' do
    it 'sees info to get started' do
      visit get_started_path

      expect(page).to have_content('Browse tutorials from the homepage.')
      expect(page).to have_content('Filter results by selecting a filter on the side bar of the homepage.')
      expect(page).to have_content('Register to bookmark segments.')
      expect(page).to have_content('Sign in with census if you are a current student for addition content.')
      expect(page).to have_link('homepage', count: 2, href: root_path)
      expect(page).to have_link('Sign in', href: login_path)
    end
  end
end
