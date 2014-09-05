module Apriori
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
        apriori = Apriori.new(10, sample_data)
        expect(apriori.count_frequency(sample_data)).to eql({
          :Mango => 3,
          :Onion => 3,
          :Nintendo => 2,
          :Keychain => 5,
          :Eggs => 4,
          :Yoyo => 3,
          :Doll => 1,
          :Apple => 1,
          :Umbrella => 1,
          :Corn => 2,
          :Icecream => 1
          })
      end
    end

  end
end
