describe BeelineInspector do
  describe '#collect_data' do
    context 'prepaid' do
      it 'should return users data', :vcr do
        resp = BeelineInspector.new(prepaid_params).collect_data
        pp resp
        expect(resp.class).to be Hash
      end
    end
    context 'postpaid' do
      it 'should return users data', :vcr do
        resp = BeelineInspector.new(postpaid_params).collect_data
        pp resp
        expect(resp.class).to be Hash
      end
    end
  end
end
