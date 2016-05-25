require './application'
# You need valid phone_number_credentioals in order to test the application
# They are not included to the repository due security reasons
# Use phone_number_credentials.rb.sample to create your
# own phone_number_credentials.rb file
require_relative 'phone_number_credentials'
# After first run stubs will be created via VCR https://github.com/vcr/vcr
# If external API will change than simply remove spec/vcr_cassettes
# to create stabs again
require_relative 'support/vcr_initializer'

def base_params
  {
    current_plan: true,
    balance: true,
    services: true,
    detail: true,
    start_date: '2015-08-01',
    end_date: '2015-08-31'
  }
end

def prepaid_params
  VCR.use_cassette('prepaid_beeline_auth') do
    calculate_prepaid_params unless @prepaid_params
  end
  @prepaid_params
end

def postpaid_params
  VCR.use_cassette('postpaid_beeline_auth') do
    calculate_postpaid_params unless @postpaid_params
  end
  @postpaid_params
end

RSpec::Matchers.define :be_pdf do
  match do |actual|
    Base64.decode64(actual)[0, 4] == '%PDF'
  end
end

private

def calculate_prepaid_params
  @prepaid_params = base_params.merge(PREPAID_CREDENTIALS)
  @prepaid_params[:payment_type] = :prepaid
  @prepaid_params[:api_client] = BeelineRestApiClient.new(
    PREPAID_CREDENTIALS[:phone_number],
    PREPAID_CREDENTIALS[:password]
  )
end

def calculate_postpaid_params
  @postpaid_params = base_params.merge(POSTPAID_CREDENTIALS)
  @postpaid_params[:payment_type] = :postpaid
  @postpaid_params[:api_client] = BeelineRestApiClient.new(
    POSTPAID_CREDENTIALS[:phone_number],
    POSTPAID_CREDENTIALS[:password]
  )
end
