class ApiTokenGenerator

  def self.generate api_key, secret_token
    Digest::SHA2.hexdigest(api_key + secret_token)
  end 
  
end
