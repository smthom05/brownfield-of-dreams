require 'rails_helper'

feature 'as a visitor' do
  describe 'when visiting the about page' do
    it 'sees site info' do
      visit '/about'

      expect(page).to have_content(
        'This application is designed to pull in youtube information' \
        ' to populate tutorials from Turing School of Software and Design\'s' \
        ' youtube channel. It\'s designed for anyone learning how to code,' \
        ' with additional features for current students.'
      )
    end
  end
end
