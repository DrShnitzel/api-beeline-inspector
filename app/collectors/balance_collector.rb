class BalanceCollector < BaseCollector
  private

  def url
    "info/#{@params[:payment_type]}Balance?ctn=#{@params[:phone_number]}"
  end

  def prepare_response(resp)
    resp['balance']
  end
end
