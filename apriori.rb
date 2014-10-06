#!/usr/bin/env ruby
require 'apriori'

# instantiate new hash
data_set = {}
transaction = 0

# read text file
f = File.open("database5.txt", "r")

# set each line of text file as a transaction in the hash
f.each_line do |line|
  transaction += 1
  data_set[transaction] = line.split(' ')
end
f.close

# create new Apriori ItemSet
item_set = Apriori::ItemSet.new(data_set)
# mine item set to produce association rules
association_rules = item_set.mine(30,50)

# print out association rules
association_rules.each do |rule, confidence|
  puts rule
  puts confidence
  puts '++++++++++'
end
