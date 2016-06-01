class ServicesCollector < BaseCollector
  private

  def url
    "info/serviceList?ctn=#{@params[:phone_number]}"
  end

  def prepare_response(resp)
    resp['services'].each_with_object([]) do |item, acc|
      acc << prepare_response_item(item) if not_technical?(item)
    end
  end

  def prepare_response_item(item)
    {
      name: item['entityName'],
      subscription_payment: item['rcRate'],
      payment_period: payment_period(item),
      removable: item['removeInd']
    }
  end

  def not_technical?(item)
    item['viewInd'] == 'Y'
  end
end
