CONFIG = YAML.load_file(Rails.root.join("config/app.yml"))[Rails.env]

module APP_CONFIG

  EVIRONMENT = CONFIG['evironment']
  
  module GMAIL_AUTH
    CLIENT_ID  = CONFIG['gmail_auth']['client_id']
    SECRET_KEY = CONFIG['gmail_auth']['secret_key']
  end

  module ERP
    USERNAME = CONFIG['erp']['username']
    PASSWORD = CONFIG['erp']['password']
    HOST = CONFIG['erp']['host']
  end

  module INTRANET
    URL = CONFIG['intranet']['url']
    APP_ID = CONFIG['intranet']['app_id']
    API_TOKEN = CONFIG['intranet']['api_token']
  end

  module GFP
    URL = CONFIG['gfp']['url']
    APP_ID = CONFIG['gfp']['app_id']
    API_TOKEN = CONFIG['gfp']['api_token']
  end

  REPORT_EMAIL = CONFIG['report_email']

end
