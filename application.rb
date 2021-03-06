require 'byebug'
require 'sinatra/base'
require 'sinatra/param'
require './app/beeline_inspector'
require './app/errors/errors'
require './config/configus'
require 'dotenv'

Dotenv.load

class Application < Sinatra::Base
  helpers Sinatra::Param

  get configus.data_address do
    validate_params
    body = BeelineInspector.new(params).collect_data
    respond_with!(200, body)
  end

  error AuthError do
    body = { message: 'Cannot authenticate with the provided credentials' }
    respond_with!(401, body)
  end

  private

  def validate_params
    param :phone_number, String, required: true
    param :password, String, required: true
    configus.avaible_resources.each do |name|
      param name, :boolean
    end
  end

  def respond_with!(status_code, body = {})
    status status_code
    content_type :json
    halt body.to_json
  end
end
