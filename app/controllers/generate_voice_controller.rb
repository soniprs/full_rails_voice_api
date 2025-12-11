class GenerateVoiceController < ApplicationController
 def create
   req = AudioRequest.create!(text: params[:text], status: 'queued')
   GenerateVoiceJob.perform_later(req.id)
   render json: {id: req.id, status: req.status}
 end
end