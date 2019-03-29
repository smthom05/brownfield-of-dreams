require 'rails_helper'

feature 'As a logged in user' do
  context 'when visiting a tutorial show page' do
    before :each do
      @user = create(:user)
      @tutorial = create(:tutorial)
      @tutorial2 = create(:tutorial)
      @video1 = create(:video, tutorial_id: @tutorial.id)
      @video2 = create(:video, tutorial_id: @tutorial.id)
      @video3 = create(:video, tutorial_id: @tutorial.id)
    end
    it 'sees a list of videos in that tutorial when there are no videos' do
      login_as(@user)
      visit tutorial_path(@tutorial.id)

      within '.tutorial-videos' do
        expect(page).to have_css('.show-link', count: 3)
        expect(page).to have_content(@video1.title)
        expect(page).to have_content(@video2.title)
        expect(page).to have_content(@video3.title)
      end
    end

    it 'does not error out when there are no videos' do
      login_as(@user)
      visit tutorial_path(@tutorial2.id)

      expect(page).to have_content('Videos')
    end
  end
end
