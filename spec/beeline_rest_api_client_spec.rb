describe BeelineInspector do
  describe '#collect_data' do
    let(:params) do
      {
        current_plan: true,
        balance: true,
        services: true,
        detail: true,
        start_date: '2015-08-01',
        end_date: '2015-08-31'
      }
    end
    context 'prepaid' do
      it 'should return users data' do
        credentials = PREPAID_CREDENTIALS
        resp = BeelineInspector.new(params.merge(credentials)).collect_data
        pp resp
        expect(resp.class).to be Hash
      end
    end
    context 'postpaid' do
      it 'should return users data' do
        params = POSTPAID_CREDENTIALS
        resp = BeelineInspector.new(params).collect_data
        pp resp
        expect(resp.class).to be Hash
      end
    end
  end
end
