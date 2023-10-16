if Rails.application.credentials.spotify_secret
  RSpotify.authenticate(Rails.application.credentials.spotify_id, Rails.application.credentials.spotify_secret)
end
