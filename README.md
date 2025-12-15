# Voice Generation API (Rails)

## Features
- /generate_voice API
- ElevenLabs TTS integration
- Background jobs (Sidekiq)
- Audio storage via Cloudinary/S3 compatible
- Simple UI
- RSpec tests
- Railway ready

## Setup
```bash
bundle install
rails db:setup
bundle exec sidekiq
rails s
```

## ENV Variables
ELEVENLABS_API_KEY=xxx
CLOUDINARY_URL=xxx
REDIS_URL=xxx
