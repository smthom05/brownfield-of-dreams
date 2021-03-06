require 'rails_helper'

describe 'A registered user' do # rubocop:disable Metrics/BlockLength
  before :each do
    @tutorial = create(:tutorial, title: 'How to Tie Your Shoes')
    @video = create(:video,
                    title: 'The Bunny Ears Technique',
                    tutorial: @tutorial)
    @user = create(:user)
  end

  it 'can add videos to their bookmarks' do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(@user)

    visit tutorial_path(@tutorial)

    expect {
      click_button 'Bookmark'
    }.to change { UserVideo.count }.by(1)

    expect(page).to have_content('Bookmark added to your dashboard')
  end

  it 'can\'t add the same bookmark more than once' do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(@user)

    visit tutorial_path(@tutorial)

    click_on 'Bookmark'
    expect(page).to have_content('Bookmark added to your dashboard')
    click_on 'Bookmark'
    expect(page).to have_content('Already in your bookmarks')
  end
end
