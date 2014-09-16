describe Apriori::Algorithm do
  before do
    @apriori = FactoryGirl.build(:algorithm)
  end

  context '#mine' do
    it 'returns all association rules meeting the minimum support and confidence' do
      @apriori.mine(50)
    end
  end

  context '#create_subsets' do
    it 'returns all possible subsets of an array' do
      array = [1,2,3]
      expect(@apriori.create_subsets(array)).to eql([[1],[2],[3],[1,2],[1,3],[2,3]])
    end
  end

  context '#confidence' do
    it 'will return a rule with support and confidence' do
      set1 = ['Eggs']
      set2 = ['Onion', 'Keychain']
      expect(@apriori.confidence(set1, set2)).to eql(75.0)
    end
  end

  context '#support' do
    it 'will return the support of an item' do
      item = ['Mango']
      expect(@apriori.support(item)).to eql((3.to_f/5) * 100)
    end
  end

  context '#count_frequency' do
    it 'will return the frequency of an item in the data set' do
    item = ['Mango']
    expect(@apriori.count_frequency(item)).to eql(3)
    end
  end

  context '#contains_all?' do
    it 'will return true if one array contains all elements of sub set' do
      set = [1,2,3]
      subset = [2,1]
      expect(@apriori.contains_all?(set, subset)).to be true
    end

    it 'will return false if one array does not contain all the elements of a sub set' do
      set = [1,2,3,4]
      subset = [2,1,5]
      expect(@apriori.contains_all?(set, subset)).to be false
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
