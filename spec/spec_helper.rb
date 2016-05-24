require './application'
require_relative 'phone_number_credentials'

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
  unless @prepaid_params
    @prepaid_params = base_params.merge(PREPAID_CREDENTIALS)
    @prepaid_params[:payment_type] = :prepaid
    @prepaid_params[:api_client] = BeelineRestApiClient.new(
      PREPAID_CREDENTIALS[:phone_number],
      PREPAID_CREDENTIALS[:password]
    )
  end
  @prepaid_params
end

def postpaid_params
  unless @postpaid_params
    @postpaid_params = base_params.merge(POSTPAID_CREDENTIALS)
    @postpaid_params[:payment_type] = :postpaid
    @postpaid_params[:api_client] = BeelineRestApiClient.new(
      POSTPAID_CREDENTIALS[:phone_number],
      POSTPAID_CREDENTIALS[:password]
    )
  end
  @postpaid_params
end

RSpec::Matchers.define :be_pdf do
  match do |actual|
    Base64.decode64(actual)[0, 4] == '%PDF'
  end
end
