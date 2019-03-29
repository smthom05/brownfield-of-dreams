require 'rails_helper'

RSpec.describe User, type: :model do # rubocop:disable Metrics/BlockLength
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:uid) }
  end

  describe 'relationships' do
    it { should have_many :friends }
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com',
                         password: 'password',
                         first_name: 'Jim',
                         role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com',
                          password: 'admin',
                          first_name: 'Bob',
                          role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'instance methods' do # rubocop:disable Metrics/BlockLength
    describe '#not_friended?' do
      it 'returns a boolean checking if they are friends' do
        user1 = create(:user, uid: 1)
        user2 = create(:user, uid: 2)

        expect(user1.not_friended?(user2.uid)).to eq(true)

        Friend.create(user_id: user1.id, friend_id: user2.id)

        expect(user1.not_friended?(user2.uid)).to eq(false)
      end
    end

    describe '#bookmarks' do
      it 'returns an array of all bookmarked videos' do
        user = create(:user)
        tutorial = create(:tutorial)
        tutorial2 = create(:tutorial)
        tutorial3 = create(:tutorial)
        video = create(:video, tutorial_id: tutorial3.id)
        video2 = create(:video, tutorial_id: tutorial.id)
        video3 = create(:video, tutorial_id: tutorial2.id)
        uservideo = create(:user_video, user_id: user.id, video_id: video2.id)
        uservideo2 = create(:user_video, user_id: user.id, video_id: video3.id)
        uservideo3 = create(:user_video, user_id: user.id, video_id: video.id)

        expected = [tutorial.title, tutorial2.title, tutorial3.title]
        actual = user.bookmarks.map(&:tutorial_title)

        expect(actual).to eq(expected)
      end
    end
  end

  describe '::find_token(user_id)' do
    it 'returns the token for the specified user' do
      user = create(:user, token: 'ailrtjpoaerihgoaeirihgoarihjgoaerjg')
      create(:user, token: 'zoidjtoainewgorngoaitrfgoigjsroitgr')

      expect(User.find_token(user.id)).to eq(user.token)
    end
  end
end
