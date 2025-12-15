require 'rails_helper'

RSpec.describe VoiceGenerationJob, type: :job do
  let(:voice_request) { create(:voice_request) }

  it "updates status to completed on success" do
    allow_any_instance_of(ElevenLabsService)
      .to receive(:call)
      .and_return("/test.mp3")

    described_class.perform_now(voice_request.id)

    voice_request.reload
    expect(voice_request.status).to eq("completed")
    expect(voice_request.audio_url).to eq("/test.mp3")
  end

  it "marks request as failed on error" do
    allow_any_instance_of(ElevenLabsService)
      .to receive(:call)
      .and_raise("API error")

    described_class.perform_now(voice_request.id)

    voice_request.reload
    expect(voice_request.status).to eq("failed")
    expect(voice_request.error).to eq("API error")
  end
end
