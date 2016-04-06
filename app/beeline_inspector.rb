require_relative 'beeline_rest_api_client'
require_relative 'collectors/base_collector'
collectors_path = './app/collectors/*.rb'
Dir[collectors_path].each { |file| require file }

class BeelineInspector
  def initialize(params)
    @params = params
    @params[:api_client] = BeelineRestApiClient.new(
      params[:phone_number],
      params[:password]
    )
    @data = {}
  end

  def collect_data
    @params[:payment_type] = PaymentTypeCollector.new(@params).collect
    @data[:payment_type] =  @params[:payment_type]
    raise 'payment_type required' unless @params[:payment_type]
    configus.avaible_resources.each do |name|
      collect_data_by_name(name) if @params[name]
    end
    { message: @data }
  end

  private

  def collect_data_by_name(name)
    collector = Object.const_get("#{camelize(name)}Collector")
    @data[name] = collector.new(@params).collect
  end

  def camelize(value)
    value.to_s.split('_').map(&:capitalize).join
  end
end
