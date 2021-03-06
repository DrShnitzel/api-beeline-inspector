describe PaymentTypeCollector do
  describe '#collect' do
    context 'with prepaid params' do
      it 'returns :prepaid', :vcr do
        resp = PaymentTypeCollector.new(prepaid_params).collect
        expect(resp).to be :prepaid
      end
    end
    context 'with postpaid params' do
      it 'returns :postpaid', :vcr do
        resp = PaymentTypeCollector.new(postpaid_params).collect
        expect(resp).to be :postpaid
      end
    end
  end
end
