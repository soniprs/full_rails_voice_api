# Voice Generation API (Ruby on Rails)

## Overview

This is a **Ruby on Rails 7 application** that allows users to:

* Generate speech audio from text via **ElevenLabs API**
* Store and view previously generated audio files
* Play generated audio directly in the browser
* Maintain a history of all generated voice requests

The app includes:

* Rails API endpoint `/generate_voice`
* Background job processing via **ActiveJob**
* Minimal, interview-friendly UI
* Full **RSpec test coverage**

---

## Setup Instructions (GitHub / Local)

Follow these steps to run the app locally:

### 1️⃣ Clone the repository

```bash
git clone https://github.com/yourusername/voice_api_apps.git
cd voice_api_apps
```

### 2️⃣ Install dependencies

```bash
bundle install
yarn install # if using JS packages
```

### 3️⃣ Configure Environment Variables

Create a `.env` file in the project root (ignored by GitHub) with:

```bash
# Rails
RAILS_ENV=development
SECRET_KEY_BASE=<your_generated_key>   # rails secret
RAILS_SERVE_STATIC_FILES=true

# Database
DATABASE_URL=sqlite3:db/development.sqlite3

# ElevenLabs API
ELEVENLABS_API_KEY=<your_elevenlabs_api_key>
```

> Note: In production (Railway), set these in Railway environment variables instead.

### 4️⃣ Run Database Migrations

```bash
rails db:create
rails db:migrate
```

### 5️⃣ Run the Rails Server

```bash
rails s
```

* Open [http://localhost:3000](http://localhost:3000) in your browser.
* You should see the **Voice Generation UI** with:

  * Text input for generating speech
  * Status display for processing
  * Audio playback
  * History of generated audio

### 6️⃣ Run Tests (RSpec)

```bash
bundle exec rspec
```

* All tests should pass (models, controller, background jobs, and services).
* Ensure **test DB is migrated**:

```bash
rails db:migrate RAILS_ENV=test
```

### 7️⃣ Generate Audio via API

**Endpoint:** `POST /generate_voice`

* **Request (JSON)**:

```json
{
  "text": "Hello world"
}
```

* **Response (JSON)**:

```json
{
  "id": 1,
  "text": "Hello world",
  "status": "queued",
  "audio_url": null
}
```

Audio will be processed asynchronously and available in `/voices` history.

### 8️⃣ View Voice History

**Endpoint:** `GET /voices`

* Returns a JSON array of all voice requests:

```json
[
  {
    "id": 1,
    "text": "Hello world",
    "status": "completed",
    "audio_url": "/uploads/audio_1.mp3",
    "created_at": "2025-12-15T10:00:00Z"
  }
]
```

### 9️⃣ Notes

* **ElevenLabs API Key**: Required for voice generation.
* **Background Jobs**: Handled by Rails `ActiveJob` (async adapter).
* **UI**: Minimal, functional, interview-friendly.
* **Database**: Development uses SQLite; production should use PostgreSQL or other persistent DB.

### 10️⃣ Optional: Deploy on Railway

1. Create Railway project → Deploy from GitHub
2. Set environment variables (ELEVENLABS_API_KEY, SECRET_KEY_BASE, DATABASE_URL)
3. Precompile assets in production: `RAILS_ENV=production bundle exec rake assets:precompile`
4. Run database migrations: `railway run rails db:migrate`

### 11️⃣ Repository Structure

```
app/
  controllers/
    voice_controller.rb
  jobs/
    voice_generation_job.rb
  models/
    voice
```
