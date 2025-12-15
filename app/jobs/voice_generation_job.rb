class VoiceGenerationJob < ApplicationJob
  queue_as :default

  def perform(id)
    record = VoiceRequest.find(id)
    response = ElevenLabsService.new(record.text).call
    record.update!(audio_url: response, status: 'completed')
  rescue => e
    record.update!(status: 'failed', error: e.message)
  end
end
