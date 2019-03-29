require 'rails_helper'

describe 'Tutorials API' do # rubocop:disable Metrics/BlockLength
  it 'sends a list of tutorials' do
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial)

    video1 = create(:video, tutorial_id: tutorial1.id)
    video2 = create(:video, tutorial_id: tutorial1.id)
    video3 = create(:video, tutorial_id: tutorial2.id)
    video4 = create(:video, tutorial_id: tutorial2.id)


    get '/api/v1/tutorials'

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed.first[:id]).to eq(tutorial1.id)
    expect(parsed.first[:videos].first[:id]).to eq(video1.id)
    expect(parsed.first[:videos].last[:id]).to eq(video2.id)
    expect(parsed.last[:id]).to eq(tutorial2.id)
    expect(parsed.last[:videos].first[:id]).to eq(video3.id)
    expect(parsed.last[:videos].last[:id]).to eq(video4.id)
  end

  it 'sends a single tutorial' do
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial)

    video1 = create(:video, tutorial_id: tutorial1.id)
    video2 = create(:video, tutorial_id: tutorial1.id)
    video3 = create(:video, tutorial_id: tutorial2.id)
    video4 = create(:video, tutorial_id: tutorial2.id)

    get "/api/v1/tutorials/#{tutorial1.id}"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:id]).to eq(tutorial1.id)
    expect(parsed[:videos].first[:id]).to eq(video1.id)
    expect(parsed[:videos].last[:id]).to eq(video2.id)
  end

  context 'as an admin' do
    it 'can change the sequence of tutorials' do # rubocop:disable Metrics/BlockLength, Metrics/LineLength
      admin = create(:user, role: :admin)

      allow_any_instance_of(
        Admin::Api::V1::TutorialSequencerController
      ).to receive(:current_user).and_return(admin)

      tutorial = create(:tutorial)

      video1 = create(:video, tutorial_id: tutorial.id)
      video2 = create(:video, tutorial_id: tutorial.id)

      get "/api/v1/tutorials/#{tutorial.id}"
      json = JSON.parse(response.body)

      json['videos'].each do |video|
        expect(video['position']).to eq(0)
      end
      expect(json['videos'][0]['id']).to eq(video1.id)
      expect(json['videos'][1]['id']).to eq(video2.id)

      put "/admin/api/v1/tutorial_sequencer/#{tutorial.id}", params: {
        tutorial_sequencer: { _json: [video2.id, video1.id] }
      }
      get "/api/v1/tutorials/#{tutorial.id}"
      json = JSON.parse(response.body)

      counter = 1
      json['videos'].each do |video|
        expect(video['position']).to eq(counter)
        counter += 1
      end
      expect(json['videos'][0]['id']).to eq(video2.id)
      expect(json['videos'][1]['id']).to eq(video1.id)
    end
  end
end
