require './application'
require_relative 'support/vcr_initializer'

ENV['RACK_ENV'] = 'testing'

ENV['PREPAID_PASSWORD'] ||= 'PREPAID_PASSWORD'
ENV['POSTPAID_PASSWORD'] ||= 'POSTPAID_PASSWORD'

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

def base_params
  {
    current_plan: true,
    balance: true,
    services: true,
    detail: true,
    additional_detail: true,
    start_date: '2016-03-01',
    end_date: '2016-03-31',
    additional_date: '2016-04-18'
  }
end

def calculate_prepaid_params
  params = { phone_number: '9603197766', password: ENV['PREPAID_PASSWORD'] }
  @prepaid_params = base_params.merge(params)
  @prepaid_params[:payment_type] = :prepaid
  @prepaid_params[:api_client] = BeelineRestApiClient.new(
    params[:phone_number],
    ENV['PREPAID_PASSWORD']
  )
end

def calculate_postpaid_params
  params = { phone_number: '9663592847', password: ENV['POSTPAID_PASSWORD'] }
  @postpaid_params = base_params.merge(params)
  @postpaid_params[:payment_type] = :postpaid
  @postpaid_params[:api_client] = BeelineRestApiClient.new(
    params[:phone_number],
    ENV['POSTPAID_PASSWORD']
  )
end
