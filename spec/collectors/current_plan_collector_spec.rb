describe CurrentPlanCollector do
  it 'returns current plan info', :vcr do
    resp = CurrentPlanCollector.new(prepaid_params).collect
    expected_resp = {
      name: 'Go!',
      subscription_payment: 0.0,
      payment_period: nil
    }
    expect(resp).to eq expected_resp
  end
end
