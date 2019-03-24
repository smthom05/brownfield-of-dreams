require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
    it {should validate_uniqueness_of(:uid)}
  end

  describe 'relationships' do
    it {should have_many :friends}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'instance methods' do
    describe '#not_friended?' do
      it 'returns a boolean checking if they are friends' do
        user_1 = create(:user, uid: 1)
        user_2 = create(:user, uid: 2)

        expect(user_1.not_friended?(user_2.uid)).to eq(true)

        Friend.create(user_id: user_1.id, friend_id: user_2.id)

        expect(user_1.not_friended?(user_2.uid)).to eq(false)
      end
    end

    describe '#bookmarks' do
      it 'returns an array of all bookmarked videos' do
        user = create(:user)
        tutorial = create(:tutorial)
        tutorial_2 = create(:tutorial)
        tutorial_3 = create(:tutorial)
        video = create(:video, tutorial_id: tutorial_3.id)
        video_2 = create(:video, tutorial_id: tutorial.id)
        video_3 = create(:video, tutorial_id: tutorial_2.id)
        uservideo = create(:user_video, user_id: user.id, video_id: video_2.id)
        uservideo_2 = create(:user_video, user_id: user.id, video_id: video_3.id)
        uservideo_3 = create(:user_video, user_id: user.id, video_id: video.id)

        expected = [tutorial.title, tutorial_2.title, tutorial_3.title]
        actual = user.bookmarks.map {|b| b.tutorial_title }

        expect(actual).to eq(expected)
      end
    end
  end

  describe '::find_token(user_id)' do
    it 'returns the token for the specified user' do
      user = create(:user, token: "ailrtjpoaerihgoaeirihgoarihjgoaerjg")
      create(:user, token: "zoidjtoainewgorngoaitrfgoigjsroitgr")

      expect(User.find_token(user.id)).to eq(user.token)
    end
  end
end
