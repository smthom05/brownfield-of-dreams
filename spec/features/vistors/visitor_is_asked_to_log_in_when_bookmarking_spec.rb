require 'rails_helper'

describe 'visitor visits video show page' do
  it 'clicks on the bookmark page and gets a flash message saying to log in' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    expect {
      click_link 'Bookmark'
    }.to change { UserVideo.count }.by(0)

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content('User must login to bookmark videos')
  end
end
