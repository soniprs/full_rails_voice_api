Rails.application.routes.draw do
  root 'voice#home'

  post '/generate_voice', to: 'voice#generate'
  get '/voices', to: 'voice#index'
end
