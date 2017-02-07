require 'parasut_ruby_sdk'

PARASUT_CLIENT_ID     = ''
PARASUT_CLIENT_SECRET = ''
PARASUT_CALLBACK_URL  = 'urn:ietf:wg:oauth:2.0:oob'
PARASUT_USERNAME      = ''
PARASUT_USER_PASSWORD = ''
PARASUT_COMPANY_ID    = ''

config = {
  client_id: PARASUT_CLIENT_ID,
  client_secret: PARASUT_CLIENT_SECRET,
  callback_url: PARASUT_CALLBACK_URL,
  username: PARASUT_USERNAME,
  password: PARASUT_USER_PASSWORD,
  company_id: PARASUT_COMPANY_ID,
  access_token: nil,
  refresh_token: nil
}

# Get access and refresh token
tokens = ParasutRubySdk::REST::BaseRequest.new(config).get_token
config['access_token'] = tokens.access_token
config['refresh_token'] = tokens.refresh_token

# Account
# -------------------------------------------------------------
account = ParasutRubySdk::REST::Account.new(config)
puts account.all