describe BalanceCollector do
  describe '#collect' do
    context 'with prepaid payment type' do
      it 'returns balance' do
        resp = BalanceCollector.new(prepaid_params).collect
        expect(resp.class).to be Float
      end
    end
    context 'with postpaid payment type' do
      it 'returns balance' do
        resp = BalanceCollector.new(postpaid_params).collect
        expect(resp.class).to be Float
      end
    end
  end
end
