require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.filter_sensitive_data('PREPAID_PASSWORD') { ENV['PREPAID_PASSWORD'] }
  c.filter_sensitive_data('POSTPAID_PASSWORD') { ENV['POSTPAID_PASSWORD'] }
end
