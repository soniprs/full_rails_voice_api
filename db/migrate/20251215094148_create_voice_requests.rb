class CreateVoiceRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :voice_requests do |t|
      t.text :text, null: false
      t.string :status, default: 'queued'
      t.string :audio_url
      t.text :error

      t.timestamps
    end
  end
end
