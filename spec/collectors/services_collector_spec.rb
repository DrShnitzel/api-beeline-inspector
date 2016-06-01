describe ServicesCollector do
  describe '#collect' do
    it 'returns services list', :vcr do
      resp = ServicesCollector.new(prepaid_params).collect
      expect(resp.class).to be Array
    end
  end
end
