CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = 'crabucket'
  config.aws_acl    = 'public-read'  

  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7  

  config.aws_credentials = { 
  	# access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'), 
  	# secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'), 
  	# region: ENV.fetch('AWS_REGION')  }
  	access_key_id: 'sf', 
  	secret_access_key: 'dsf', 
  	region: 'dsf' }
end