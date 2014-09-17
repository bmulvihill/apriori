describe Apriori::Algorithm do
  before do
    @apriori = FactoryGirl.build(:algorithm)
  end

  context '#mine' do
    it 'returns all association rules meeting the minimum support and confidence' do
      @apriori.mine(50)
    end
  end

  context '#reject_candidates' do
    it 'retrieves a list of candidates that meet minimum support' do
      @apriori.min_support = 50
      expect(@apriori.reject_candidates(@apriori.candidates)).to eql([
        ['Mango'],
        ['Onion'],
        ['Keychain'],
        ['Eggs'],
        ['Yoyo']
        ])
    end
  end

end
