class EloS3

  def initialize
    fog_config = YAML.load_file(Rails.root.join("config/app.yml"))[Rails.env]['s3']
    connection = Fog::Storage.new({
      :provider               => 'AWS',
      :aws_access_key_id      => fog_config['aws_access_key_id'],
      :aws_secret_access_key  => fog_config['aws_secret_access_key'],
      :region                 => fog_config['region']
    })
    @directory = connection.directories.get(fog_config['directory'])
  end

  def get(path)
    file = @directory.files.get(path)
    if file
      url = file.url(Time.now.to_i + 60)
    end

    url
  end

end




