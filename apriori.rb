#!/usr/bin/env ruby
require 'apriori'


databases = ['database1.txt', 'database2.txt', 'database3.txt', 'database4.txt', 'database5.txt']

# read text file
databases.each do |database|
  transaction = 0
  # instantiate new hash
  data_set = {}

  puts "======================"
  puts "Now mining #{database}"
  puts "======================"

  f = File.open(database, "r")

  # set each line of text file as a transaction in the hash
  f.each_line do |line|
    transaction += 1
    data_set[transaction] = line.split(' ')
  end
  f.close

  # create new Apriori ItemSet
  item_set = Apriori::ItemSet.new(data_set)

  # mine item set to produce association rules
  association_rules = item_set.mine(40,60)

  # print out association rules
  association_rules.each do |name, rule|
    puts name
    puts "Support: #{rule[0]}, Confidence: #{rule[1]}"
    puts '----------'
  end
end
