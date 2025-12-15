class VoiceRequest < ApplicationRecord
  validates :text, presence: true
end
