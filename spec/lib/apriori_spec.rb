describe Apriori do
  let(:sample_data) do
    {
      t1: ['Mango', 'Onion', 'Nintendo', 'Keychain', 'Eggs', 'Yoyo'],
      t2: ['Doll', 'Onion', 'Nintendo', 'Keychain', 'Eggs', 'Yoyo'],
      t3: ['Mango', 'Apple', 'Keychain', 'Eggs'],
      t4: ['Mango', 'Umbrella', 'Corn', 'Keychain', 'Yoyo'],
      t5: ['Corn', 'Onion', 'Onion', 'Keychain', 'Icecream', 'Eggs']
      }
  end

  context '#create_subsets' do
    it 'returns all possible subsets of an array' do
      apriori = Apriori::Algorithm.new(sample_data,50)
      array = [1,2,3]
      expect(apriori.create_subsets(array)).to eql([[1],[2],[3],[1,2],[1,3],[2,3]])
    end
  end

  context '#confidence' do
    it 'will return a rule with support and confidence' do
      apriori =  Apriori::Algorithm.new(sample_data,50)
      set1 = ['Eggs']
      set2 = ['Onion', 'Keychain']
      expect(apriori.confidence(set1, set2)).to eql(75.0)
    end
  end

  context '#support' do
    it 'will return the support of an item' do
      apriori =  Apriori::Algorithm.new(sample_data,50)
      item = ['Mango']
      expect(apriori.support(item)).to eql((3.to_f/5) * 100)
    end
  end

  context '#count_frequency' do
    it 'will return the frequency of an item in the data set' do
    apriori =  Apriori::Algorithm.new(sample_data,50)
    item = ['Mango']
    expect(apriori.count_frequency(item)).to eql(3)
    end
  end

  context '#mine' do
    it 'returns all association rules meeting the minimum support and confidence' do
      apriori =  Apriori::Algorithm.new(sample_data,50)
      apriori.mine
    end
  end

  context '#contains_all?' do
    it 'will return true if one array contains all elements of sub set' do
      apriori =  Apriori::Algorithm.new(sample_data, 50)
      set = [1,2,3]
      subset = [2,1]
      expect(apriori.contains_all?(set, subset)).to be true
    end

    it 'will return false if one array does not contain all the elements of a sub set' do
      apriori =  Apriori::Algorithm.new(sample_data, 50)
      set = [1,2,3,4]
      subset = [2,1,5]
      expect(apriori.contains_all?(set, subset)).to be false
    end
  end

  context '#retrieve_candidates' do
    it 'retrieves all candidates that meet minimum support' do
      apriori =  Apriori::Algorithm.new(sample_data, 50)
      expect(apriori.retrieve_candidates(apriori.list)).to eql([
        'Mango',
        'Onion',
        'Keychain',
        'Eggs',
        'Yoyo'
        ])
    end
  end

  context '#create_new_list' do
    it 'creates a new list of candidates' do
      apriori =  Apriori::Algorithm.new(sample_data, 50)
      candidates = apriori.retrieve_candidates(apriori.list)
      expect(apriori.create_new_list(candidates)).to eql([
        ['Mango', 'Onion'],
        ['Mango', 'Keychain'],
        ['Mango', 'Eggs'],
        ['Mango', 'Yoyo'],
        ['Onion', 'Keychain'],
        ['Onion', 'Eggs'],
        ['Onion', 'Yoyo'],
        ['Keychain', 'Eggs'],
        ['Keychain', 'Yoyo'],
        ['Eggs', 'Yoyo']
        ])
    end
  end

  context '#make_combination' do
    it 'will return all combinations for first two iterations' do
      apriori =  Apriori::Algorithm.new(sample_data, 50)
      apriori.iterate
      array =['Hi1','Hi2','Hi3']
      expect(apriori.make_combination(array)).to eql([['Hi1','Hi2'],['Hi1','Hi3'],['Hi2','Hi3']])
    end

    it 'will return the self join after the first two iterations' do
      apriori =  Apriori::Algorithm.new(sample_data, 50)
      apriori.iterate
      apriori.iterate
      array = [['Hi1','Hi2'], ['Hi1','Hi3'], ['Blah1', 'Blah2'], ['Blah1', 'Blah3']]
      expect(apriori.self_join(array)).to eql([['Hi1','Hi2','Hi3'],['Blah1','Blah2','Blah3']])
    end
  end

  context '#prune' do
    it 'will remove elements thats dont have additional elements w/ the same prefix' do
      apriori =  Apriori::Algorithm.new(sample_data, 50)
      array = ['Blah1,Blah2', 'Hi1,Hi2', 'Hi1,Hi3']
      expect(apriori.prune(array)).to eql(['Hi1,Hi2','Hi1,Hi3'])
    end
  end

  context '#self_join' do
    it 'will join elements on all but last item' do
      apriori =  Apriori::Algorithm.new(sample_data, 50)
      array = [['Hi1','Hi2'], ['Hi1','Hi3'], ['Blah1', 'Blah2'], ['Blah1', 'Blah3']]
      expect(apriori.self_join(array)).to eql([['Hi1','Hi2','Hi3'],['Blah1','Blah2','Blah3']])
    end
  end
end
