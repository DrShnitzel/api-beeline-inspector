describe CurrentPlanCollector do
  describe '#collect' do
    # There is no context because it's payment_type independent action
    before :all do
      VCR.use_cassette('plan_collector') do
        @resp = CurrentPlanCollector.new(prepaid_params).collect
      end
    end
    it 'returns current plan name' do
      expect(@resp[:name].class).to be String
    end
    it 'returns subscription payment' do
      expect(@resp[:subscription_payment].class).to be Float
    end
    it 'returns payment_period' do
      expect(@resp.key?(:payment_period)).to be true
    end
  end
end
