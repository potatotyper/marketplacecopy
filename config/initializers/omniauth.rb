Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], 
  {
    scope: 'email, profile, docs, drive, spreadsheets',
    access_type: 'offline',
    prompt: 'consent'
  }
end