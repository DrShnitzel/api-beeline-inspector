class BaseCollector
  def initialize(params)
    @params = params
    @api_client = @params[:api_client]
  end

  def collect
    resp = @api_client.make_request(url)
    prepare_response(resp)
  rescue RestClient::Exception => e
    pp e.response
    nil
  end

  private

  def url
    raise "#url must be implemented in #{self.class}"
  end

  def prepare_response
    raise "#prepare_response must be implemented #{self.class}"
  end

  def payment_period(hash)
    hash['rcRatePeriod'] ? hash['rcRatePeriod'].split('.')[-1] : nil
  end
end
