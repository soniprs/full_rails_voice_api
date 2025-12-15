require 'rails_helper'

RSpec.describe "Voice API", type: :request do
  describe "POST /generate_voice" do
    it "creates a voice request and enqueues job" do
      expect {
        post "/generate_voice", params: { text: "Hello" }
      }.to change(VoiceRequest, :count).by(1)

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)["status"]).to eq("queued")
    end

    it "returns error when text is missing" do
      post "/generate_voice", params: { text: "" }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /voices" do
    it "returns voice history" do
      create(:voice_request)
      get "/voices"

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to be >= 1
    end
  end
end
