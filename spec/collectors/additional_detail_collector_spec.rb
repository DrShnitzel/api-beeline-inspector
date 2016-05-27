describe AdditionalDetailCollector do
  describe '#collect' do
    context 'with prepaid payment type' do
      it 'returns pdf', :vcr do
        resp = AdditionalDetailCollector.new(prepaid_params).collect
        expect(resp).to be_pdf
      end
    end
    context 'with postpaid payment type' do
      it 'returns nothing', :vcr do
        resp = AdditionalDetailCollector.new(postpaid_params).collect
        expect(resp).to be nil
      end
    end
  end
end
