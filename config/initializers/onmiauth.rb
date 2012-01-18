Rails.application.config.middleware.use OmniAuth::Builder do
	provider :google_oauth2, '820837921639.apps.googleusercontent.com', 'qwR_Obw8XGhLxCy931mxLJ2M'
end