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

  context '#create_association_rules' do
    it 'creates association rules for all combinations' do
      frequent_item_set = [Apriori::List.new([['Onion'],['Keychain'],['Eggs']],1)]
      expect(@apriori.create_association_rules(frequent_item_set)).to eql({"Onion=>Keychain,Eggs"=>{:confidence=>100.0}, "Keychain=>Onion,Eggs"=>{:confidence=>60.0}, "Eggs=>Onion,Keychain"=>{:confidence=>75.0}, "Onion,Keychain=>Eggs"=>{:confidence=>100.0}, "Onion,Eggs=>Keychain"=>{:confidence=>100.0}, "Keychain,Eggs=>Onion"=>{:confidence=>75.0}})
    end
  end
end
