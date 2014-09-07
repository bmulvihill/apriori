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
      expect(apriori.create_new_set(candidates)).to eql([
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
