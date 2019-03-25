require 'rails_helper'

feature 'As a logged in user' do
  context 'when visiting a tutorial show page' do
    before :each do
      @user = create(:user)
      @tutorial = create(:tutorial)
      @tutorial_2 = create(:tutorial)
      @video_1 = create(:video, tutorial_id: @tutorial.id)
      @video_2 = create(:video, tutorial_id: @tutorial.id)
      @video_3 = create(:video, tutorial_id: @tutorial.id)
    end
    it 'sees a list of videos in that tutorial when there are no videos' do
      login_as(@user)
      visit tutorial_path(@tutorial.id)

      within '.tutorial-videos' do
        expect(page).to have_css('.show-link', count: 3)
        expect(page).to have_content(@video_1.title)
        expect(page).to have_content(@video_2.title)
        expect(page).to have_content(@video_3.title)
      end
    end

    it 'does not error out when there are no videos' do
      login_as(@user)
      visit tutorial_path(@tutorial_2.id)
      save_and_open_page
      expect(page).to have_content('Videos')
    end
  end
end
