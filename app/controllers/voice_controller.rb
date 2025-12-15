class VoiceController < ApplicationController
  protect_from_forgery with: :null_session

  def home
    @voices = VoiceRequest.order(created_at: :desc)
  end

  def generate
    return render json: { error: 'Text is required' }, status: :unprocessable_entity if params[:text].blank?

    voice = VoiceRequest.create!(
      text: params[:text],
      status: 'queued'
    )

    VoiceGenerationJob.perform_later(voice.id)

    render json: { id: voice.id, status: voice.status }
  end

  def index
    render json: VoiceRequest.order(created_at: :desc)
  end
end
