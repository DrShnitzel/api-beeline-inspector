describe DetailCollector do
  describe '#collect' do
    context 'with prepaid payment type' do
      it 'returns pdf' do
        resp = DetailCollector.new(prepaid_params).collect
        expect(resp).to be_pdf
      end
    end
    context 'with postpaid payment type' do
      it 'returns nothing' do
        resp = DetailCollector.new(postpaid_params).collect
        expect(resp).to be nil
      end
    end
  end
end
