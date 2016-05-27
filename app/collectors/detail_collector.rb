require 'base64'

class DetailCollector < BaseCollector
  REPEAT_COUNT = 120
  TIME_TO_WAIT = 1

  def collect
    return if @params[:payment_type] == :postpaid
    super
  end

  private

  def url
    "request/prepaidDetail?ctn=#{@params[:phone_number]}" \
                          "&startDate=#{@params[:start_date]}" \
                          "&endDate=#{@params[:end_date]}" \
                          '&reportType=pdf' \
                          '&emailSendInd=false' \
                          '&sessionGroupFlag=true'
  end

  def prepare_response(resp)
    @request_id = resp['requestId']
    Base64.encode64(wait_for_detail)
  end

  def wait_for_detail
    sleep(TIME_TO_WAIT) unless ENV['RACK_ENV'] == 'testing'
    REPEAT_COUNT.times do
      resp = download_detail
      return resp if pdf?(resp)
      sleep(TIME_TO_WAIT)
    end
  end

  def download_detail
    download_url = 'request/requestAttachment?' \
                   "requestId=#{@request_id}" \
                   '&unZip=true'
    @api_client.raw_request(download_url)
  end

  def pdf?(string)
    string[0, 4] == '%PDF'
  end
end
