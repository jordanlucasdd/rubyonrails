CarrierWave.configure do |config|
  
  fog_config = YAML.load_file(Rails.root.join("config/app.yml"))[Rails.env]['s3']

  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => fog_config['aws_access_key_id'],
    :aws_secret_access_key  => fog_config['aws_secret_access_key'],
    :region                 => fog_config['region']
  }
  config.fog_directory  = fog_config['directory']
  config.fog_attributes = {'Cache-Control' => 'max-age=315576000'}
  config.fog_public     = false
end