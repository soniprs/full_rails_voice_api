class GenerateVoiceJob < ApplicationJob
 queue_as :default

 def perform(id)
   req = AudioRequest.find(id)
   audio = ElevenLabsService.new(req.text).generate!
   url = StorageService.new.upload(audio)
   req.update!(status: 'completed', audio_url: url)
 end
end