require 'configus'

ENV['RACK_ENV'] ||= 'development'
puts ENV['RACK_ENV']
Configus.build ENV['RACK_ENV'] do # set current environment
  env :production do
    avaible_resources %i(
      balance
      services
      current_plan
      detail
      additional_detail
    )
  end

  env :development, parent: :production do
  end

  env :staging, parent: :development do
  end

  env :testing, parent: :development do
  end
end
