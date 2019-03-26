require 'rails_helper'

describe TutorialSequencer do
  let(:tutorial) { create(:tutorial) }
  let(:vid_1)    { create(:video, tutorial: tutorial, position: 1) }
  let(:vid_2)    { create(:video, tutorial: tutorial, position: 2) }
  let(:vid_3)    { create(:video, tutorial: tutorial, position: 3) }

  it 'exists' do
    sequence = [vid_1.id, vid_2.id, vid_3.id]
    tutorial_sequencer = TutorialSequencer.new(tutorial, sequence)
    expect(tutorial_sequencer).to be_a TutorialSequencer
  end

  context 'instance methods' do
    context '#run!' do
      it 'updates the positions of the videos' do
        sequence = [vid_3.id, vid_1.id, vid_2.id]
        tutorial_sequencer = TutorialSequencer.new(tutorial, sequence)

        tutorial_sequencer.run!

        expect(vid_1.reload.position).to eq(2)
        expect(vid_2.reload.position).to eq(3)
        expect(vid_3.reload.position).to eq(1)
      end

      it 'doesn\'t call update unless there is a change' do
        allow(tutorial).to receive(:videos).and_return([vid_1, vid_2, vid_3])

        sequence = [vid_2.id, vid_1.id, vid_3.id]
        tutorial_sequencer = TutorialSequencer.new(tutorial, sequence)

        expect(vid_1).to receive(:update).with(position: 2).once
        expect(vid_2).to receive(:update).with(position: 1).once
        expect(vid_3).to receive(:update).exactly(0).times

        tutorial_sequencer.run!
      end
    end
  end
end
