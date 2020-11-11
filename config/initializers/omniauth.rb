#Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :google_oauth2, APP_CONFIG::GMAIL_AUTH::CLIENT_ID, APP_CONFIG::GMAIL_AUTH::SECRET_KEY
#end
Rails.application.config.middleware.use OmniAuth::Builder do
 provider :microsoft_office365, ENV['d945c98b-52d4-4f51-b856-47f2d9878994'], ENV['y71D_Pxjo-~DWFj0BLab5aR38EmB_.hQv2']
end

#ffad000f