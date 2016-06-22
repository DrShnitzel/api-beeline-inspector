describe ServicesCollector do
  describe '#collect' do
    it 'returns services list', :vcr do
      resp = ServicesCollector.new(prepaid_params).collect
      expect(resp.size).to be 8
    end
  end
end
