require 'rails_helper'
require 'webmock/rspec'

RSpec.describe ElevenLabsService do
  let(:service) { described_class.new("Hello world") }

  before do
    ENV["ELEVENLABS_API_KEY"] = "test_key"
  end

  it "successfully returns audio file path" do
    stub_request(:post, /api.elevenlabs.io/)
      .to_return(
        status: 200,
        body: "FAKEAUDIO",
        headers: { "Content-Type" => "audio/mpeg" }
      )

    result = service.call
    expect(result).to match(/\.mp3/)
  end

  it "raises error on non-200 response" do
    stub_request(:post, /api.elevenlabs.io/)
      .to_return(status: 401, body: "Unauthorized")

    expect { service.call }.to raise_error(/ElevenLabs failed/)
  end
end
