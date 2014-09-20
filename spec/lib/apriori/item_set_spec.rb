describe Apriori::ItemSet do
  before do
    data = FactoryGirl.build(:sample_data)
    @item_set = Apriori::ItemSet.new(data)
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

  context '#create_association_rules' do
    it 'creates association rules for all combinations' do
      @set = Apriori::ItemSet.new({:t1 => ['1','2','3'], :t2 => ['1','2','4'], :t3 => ['1','4','5']})
      @set.create_frequent_item_sets(60)
      expect(@set.create_association_rules(50, 0)).to eql({"1=>2"=>{:confidence=>66.66666666666666}, "2=>1"=>{:confidence=>100.0}, "1=>4"=>{:confidence=>66.66666666666666}, "4=>1"=>{:confidence=>100.0}})
    end
  end

  context '#count_frequency' do
    it 'will return the frequency of an item in the data set' do
    item = ['Mango']
    expect(@item_set.count_frequency(item)).to eql(3)
    end
  end

  context '#contains_all?' do
    it 'will return true if one array contains all elements of sub set' do
      set = [1,2,3]
      subset = [2,1]
      expect(@item_set.contains_all?(set, subset)).to be true
    end

    it 'will return false if one array does not contain all the elements of a sub set' do
      set = [1,2,3,4]
      subset = [2,1,5]
      expect(@item_set.contains_all?(set, subset)).to be false
    end
  end
end
