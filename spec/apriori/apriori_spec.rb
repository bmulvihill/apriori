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

  context '#mine' do
    it 'returns all association rules meeting the minimum support and confidence' do
      apriori = Apriori.new(sample_data,50)
      apriori.mine
    end
  end

  context '#count_frequency' do
    it 'creates a hash of items and their count' do
      apriori = Apriori.new(sample_data,10)
      expect(apriori.count_frequency(apriori.list)).to eql({
        'Mango' => 3,
        'Onion' => 3,
        'Nintendo' => 2,
        'Keychain'=> 5,
        'Eggs' => 4,
        'Yoyo' => 3,
        'Doll' => 1,
        'Apple' => 1,
        'Umbrella' => 1,
        'Corn' => 2,
        'Icecream' => 1
        })
    end

    it 'will only count if all items are present in the transaction' do
      apriori = Apriori.new(sample_data, 50)
      list = [
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
        ]
        counted_list = apriori.count_frequency(list)
        expect(counted_list).to eql({
          'Mango,Onion' => 1,
          'Mango,Keychain' => 3,
          'Mango,Eggs' => 2,
          'Mango,Yoyo' => 2,
          'Onion,Keychain' => 3,
          'Onion,Eggs' => 3,
          'Onion,Yoyo' => 2,
          'Keychain,Eggs' => 4,
          'Keychain,Yoyo' => 3,
          'Eggs,Yoyo' => 2
          })
    end
  end

  context '#contains_all?' do
    it 'will return true if one array contains all elements of sub set' do
      apriori = Apriori.new(sample_data, 50)
      set = [1,2,3]
      subset = [2,1]
      expect(apriori.contains_all?(set, subset)).to be true
    end

    it 'will return false if one array does not contain all the elements of a sub set' do
      apriori = Apriori.new(sample_data, 50)
      set = [1,2,3,4]
      subset = [2,1,5]
      expect(apriori.contains_all?(set, subset)).to be false
    end
  end

  context '#retrieve_candidates' do
    it 'retrieves all candidates that meet minimum support' do
      apriori = Apriori.new(sample_data, 50)
      list = apriori.count_frequency(apriori.list)
      expect(apriori.retrieve_candidates(list)).to eql([
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
      apriori = Apriori.new(sample_data, 50)
      list = apriori.count_frequency(apriori.list)
      candidates = apriori.retrieve_candidates(list)
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

end
