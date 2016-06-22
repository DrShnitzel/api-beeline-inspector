describe configus.data_address do
  context 'with prepaid params' do
    before :all do
      VCR.use_cassette('full_prepaid') do
        get configus.data_address, prepaid_params
      end
    end
    it 'returns 200' do
      expect(last_response.status).to eq 200
    end
    configus.avaible_resources.each do |name|
      it { expect(last_response.body).to include name.to_s }
    end
  end
  context 'with postpaid params' do
    before :all do
      VCR.use_cassette('full_postpaid') do
        get configus.data_address, postpaid_params
      end
    end
    it 'returns 200' do
      expect(last_response.status).to eq 200
    end
    configus.avaible_resources.each do |name|
      it { expect(last_response.body).to include name.to_s }
    end
  end
  context 'with wrong password' do
    before :all do
      VCR.use_cassette('wrong_password') do
        get configus.data_address, phone_number: '9876543210', password: '123'
      end
    end
    it 'returns 401' do
      expect(last_response.status).to eq 401
    end
    context 'without required params' do
      before :all do
        get configus.data_address
      end
      it 'returns 400' do
        expect(last_response.status).to eq 400
      end
    end
  end
end
