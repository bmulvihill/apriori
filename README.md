Apriori Algorithm
===========
http://en.wikipedia.org/wiki/Apriori_algorithm

Implementation Project for CS 634 - Data Mining

Requirements: Ruby 2.1.X  
Installation
```bash
gem install apriori-ruby
```
Or add to Gemfile
```ruby
gem 'apriori-ruby'
```

Sample Usage
```ruby
  test_data = [[1,2,3,4], [1,2,4,5], [2,3,4,5]]
  item_set = Apriori::ItemSet.new(test_data)
  support = 50
  confidence = 60
  item_set.mine(support, confidence)
  => {"1=>2"=>100.0, "2=>1"=>66.66666666666666, "1=>4"=>100.0, "4=>1"=>66.66666666666666, "2=>3"=>66.66666666666666, "3=>2"=>100.0, "2=>4"=>100.0, "4=>2"=>100.0, "2=>5"=>66.66666666666666, "5=>2"=>100.0, "3=>4"=>100.0, "4=>3"=>66.66666666666666, "4=>5"=>66.66666666666666, "5=>4"=>100.0, "1=>2,4"=>100.0, "2=>1,4"=>66.66666666666666, "4=>1,2"=>66.66666666666666, "1,2=>4"=>100.0, "1,4=>2"=>100.0, "2,4=>1"=>66.66666666666666}
```
