require 'rails_helper'

RSpec.describe VoiceRequest, type: :model do
  it "is valid with valid attributes" do
    expect(build(:voice_request)).to be_valid
  end

  it "is invalid without text" do
    vr = build(:voice_request, text: nil)
    expect(vr).not_to be_valid
  end

  it "defaults status to queued" do
    vr = VoiceRequest.create!(text: "Test")
    expect(vr.status).to eq("queued")
  end
end
