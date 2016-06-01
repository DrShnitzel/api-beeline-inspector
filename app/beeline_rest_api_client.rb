require 'rest-client'
require 'pp'

class BeelineRestApiClient
  API_ADDRESS = 'https://my.beeline.ru/api/1.0/'
  AUTH_ERRORS_MESSAGES = %w(
    LOGIN_TRY_NUMBER_EXCEED
    AUTH_ERROR
    AUTH_EXPIRED_PASSWORD_ERROR
    AUTH_USER_BLOCKED_ERROR
    for.existent.users.only
  )

  def initialize(login, password)
    auth(login, password)
  end

  def make_request(url)
    resp = JSON.parse(raw_request(url))
    pp resp
    resp
  end

  def raw_request(url)
    RestClient.get(
      request_url(url),
      cookies: { token: @token }
    )
  end

  private

  def request_url(url)
    address = API_ADDRESS + url
    pp address
    address
  end

  def auth(login, password)
    url = "auth?login=#{login}&password=#{password}"
    resp = make_request(url)
    raise AuthError if wrong_credentials?(resp['meta']['message'])
    raise 'No token found in resp' unless resp['token']
    @token = resp['token']
  rescue RestClient::Exception => e
    pp e.response
    raise 'Beeline rest api error'
  end

  def wrong_credentials?(message)
    return unless message
    formatted_message = message.split(' (').first
    AUTH_ERRORS_MESSAGES.include?(formatted_message)
  end
end
