class PaymentTypeCollector < BaseCollector
  private

  def url
    "info/postpaidDebt?ctn=#{@params[:phone_number]}"
  end

  def prepare_response(resp)
    body = resp['meta']
    return :prepaid if body['message'] == 'postpaid.only'
    return :postpaid if body['status'] == 'OK'
    return :postpaid if body['message'] == 'FORBIDDEN (forbidden.for.all.users)'
  end
end
