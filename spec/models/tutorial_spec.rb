require 'rails_helper'

RSpec.describe Tutorial, type: :model do

  describe 'Relationships' do
    it { should have_many :videos }
  end

  describe 'Dependancies' do
    it 'destroys dependant videos' do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)
      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)
      video3 = create(:video, tutorial_id: tutorial2.id)
      video4 = create(:video, tutorial_id: tutorial2.id)

      expect { tutorial1.destroy }.to change { Video.count }.by(-2)
    end
  end

  describe 'Validations' do
  end

end
