class CurrentPlanCollector < BaseCollector
  private

  def url
    "info/pricePlan?ctn=#{@params[:phone_number]}"
  end

  def prepare_response(resp)
    info = resp['pricePlanInfo']
    {
      name: info['entityName'],
      subscription_payment: info['rcRate'],
      payment_period: payment_period(info)
    }
  end
end
