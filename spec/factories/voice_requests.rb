FactoryBot.define do
  factory :voice_request do
    text { "Hello world" }
    status { "queued" }
    audio_url { nil }
    error { nil }
  end
end
