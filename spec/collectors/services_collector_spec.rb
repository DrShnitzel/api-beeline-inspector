describe ServicesCollector do
  describe '#collect' do
    context 'with prepaid params' do
      it 'returns :prepaid', :vcr do
        resp = ServicesCollector.new(prepaid_params).collect
        expect(resp.class).to be Array
      end
    end
    context 'with postpaid params' do
      it 'returns :postpaid', :vcr do
        resp = ServicesCollector.new(postpaid_params).collect
        expect(resp.class).to be Array
      end
    end
  end
end
