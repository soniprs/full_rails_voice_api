require 'net/http'
require 'json'

class ElevenLabsService
  VOICE_ID = "21m00Tcm4TlvDq8ikWAM" # Default voice
  BASE_URL = "https://api.elevenlabs.io/v1/text-to-speech"
  MODEL_ID = "eleven_turbo_v2"     # ✅ FREE TIER SUPPORTED

  def initialize(text)
    @text = text
  end

  def call

    uri = URI("#{BASE_URL}/#{VOICE_ID}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri)
    request["xi-api-key"] = "67c3a6b0b59cb416fe524c52bf8a776f5ab243f668505c19ae81eabe46f57572"
    request["Content-Type"] = "application/json"
    request["Accept"] = "audio/mpeg"

    request.body = {
      text: @text,
      model_id: MODEL_ID
    }.to_json

    response = http.request(request)

    unless response.code.to_i == 200
      raise "ElevenLabs failed: #{response.code} - #{response.body}"
    end

    file_name = "voice_#{Time.now.to_i}.mp3"
    file_path = Rails.root.join("public", file_name)

    File.open(file_path, "wb") { |f| f.write(response.body) }

    "/#{file_name}"
  end
end
