require_relative 'detail_collector'

class AdditionalDetailCollector < DetailCollector
  private

  def url
    "request/prepaidDetail?ctn=#{@params[:phone_number]}" \
                          "&startDate=#{additional_start_date}" \
                          "&endDate=#{@params[:additional_date]}" \
                          '&reportType=pdf' \
                          '&emailSendInd=false' \
                          '&sessionGroupFlag=true'
  end

  def additional_start_date
    date = @params[:additional_date].split('-').map(&:to_i)
    Date.civil(date[0], date[1], 1)
  end
end
