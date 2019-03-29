require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'Relationships' do
    it { should have_many :users }
    it { should belong_to :tutorial }
  end

  describe 'Validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :video_id }
    it { should validate_presence_of :position }
  end
end
