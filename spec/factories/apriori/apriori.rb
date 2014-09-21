FactoryGirl.define do
  factory :algorithm, class: Apriori::Algorithm do
    initialize_with {new(FactoryGirl.build(:item_set))}
  end

  factory :item_set, class: Apriori::ItemSet do
    initialize_with {new(FactoryGirl.build(:sample_data))}
  end

  factory :sample_data, class: Hash do
    t1 ['Mango', 'Onion', 'Nintendo', 'Keychain', 'Eggs', 'Yoyo']
    t2 ['Doll', 'Onion', 'Nintendo', 'Keychain', 'Eggs', 'Yoyo']
    t3 ['Mango', 'Apple', 'Keychain', 'Eggs']
    t4 ['Mango', 'Umbrella', 'Corn', 'Keychain', 'Yoyo']
    t5 ['Corn', 'Onion', 'Onion', 'Keychain', 'Icecream', 'Eggs']
    initialize_with { attributes }
  end
end
