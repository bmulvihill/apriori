FactoryGirl.define do
  factory :item_set, class: Apriori::ItemSet do
    initialize_with {new(FactoryGirl.build(:sample_data))}
  end

  factory :sample_data, class: Array do
    initialize_with { [['Mango', 'Onion', 'Nintendo', 'Keychain', 'Eggs', 'Yoyo'],
    ['Doll', 'Onion', 'Nintendo', 'Keychain', 'Eggs', 'Yoyo'],
    ['Mango', 'Apple', 'Keychain', 'Eggs'],
    ['Mango', 'Umbrella', 'Corn', 'Keychain', 'Yoyo'],
    ['Corn', 'Onion', 'Onion', 'Keychain', 'Icecream', 'Eggs']] }
  end
end
