require 'rails_helper'

feature 'As a logged in user' do
  context 'when visiting /dashboard' do
    it 'sees all bookmarked videos' do
      user = create(:user)
      tutorial = create(:tutorial)
      video = create(:video, tutorial_id: tutorial.id)
      uservideo = create(:user_video, user_id: user.id, video_id: video.id)

      login_as(user)

      expect(page).to have_content('Bookmarked Segments')
      expect(page).to have_css('.bookmarks')
      within '.bookmarks' do
        expect(page).to have_content(tutorial.title)
        expect(page).to have_content(video.title)
      end
    end
  end
end
