require 'rails_helper'

RSpec.describe Friend, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:user_id)}
    it {should validate_presence_of(:friend_id)}
  end

  describe 'relationships' do
    it {should belong_to :user}
  end

end
