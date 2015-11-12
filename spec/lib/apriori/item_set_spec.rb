describe Apriori::ItemSet do
  before do
    data = FactoryGirl.build(:sample_data)
    @item_set = Apriori::ItemSet.new(data)
  end

  context '#mine' do
    it 'returns all association rules meeting the minimum support and confidence' do
      expect(@item_set.mine(50,90)).to eql({"Mango=>Keychain"=>100.0, "Onion=>Keychain"=>100.0, "Onion=>Eggs"=>100.0, "Eggs=>Keychain"=>100.0, "Yoyo=>Keychain"=>100.0, "Onion=>Keychain,Eggs"=>100.0, "Onion,Keychain=>Eggs"=>100.0, "Onion,Eggs=>Keychain"=>100.0})
    end

    it 'will allow you to mine the same set multiple times' do
      @item_set.mine(100,100)
      expect(@item_set.mine(50,90)).to eql({"Mango=>Keychain"=>100.0, "Onion=>Keychain"=>100.0, "Onion=>Eggs"=>100.0, "Eggs=>Keychain"=>100.0, "Yoyo=>Keychain"=>100.0, "Onion=>Keychain,Eggs"=>100.0, "Onion,Keychain=>Eggs"=>100.0, "Onion,Eggs=>Keychain"=>100.0})
    end

  end

  context '#confidence' do
    it 'will return a rule with support and confidence' do
      set1 = ['Eggs']
      set2 = ['Onion', 'Keychain']
      expect(@item_set.confidence(set1, set2)).to eql(75.0)
    end
  end

  context '#support' do
    it 'will return the support of an item' do
      item = ['Mango']
      expect(@item_set.support(item)).to eql((3.to_f/5) * 100)
    end
  end

  context '#count_frequency' do
    it 'will return the frequency of an item in the data set' do
    item = ['Mango']
    expect(@item_set.count_frequency(item)).to eql(3)
    end
  end

end
