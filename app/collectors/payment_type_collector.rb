class PaymentTypeCollector < BaseCollector
  private

  def url
    "info/postpaidDebt?ctn=#{@params[:phone_number]}"
  end

  def prepare_response(resp)
    return :prepaid if resp['meta']['message'] == 'postpaid.only'
    return :postpaid if resp['meta']['status'] == 'OK'
  end
end
