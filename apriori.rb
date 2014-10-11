#!/usr/bin/env ruby
require 'apriori'

puts "Please enter a database(s)(Seperate multiple databases by a comma): "
database = gets.chomp
puts "Please enter a minimum support percent (As a while number i.e 10):"
min_support = gets.chomp
puts "Please enter a minimum confidence percent (As a while number i.e 50):"
min_confidence = gets.chomp

databases = database.split(',')

databases.each do |database|
# read text file
  transaction = 0
  # instantiate new hash
  data_set = {}

  puts "================================"
  puts "Now mining #{database}"
  puts "================================"

  f = File.open(database, "r")

  # set each line of text file as a transaction in the hash
  f.each_line do |line|
    transaction += 1
    data_set[transaction] = line.split(' ')
  end
  f.close

  data_set.each{|transaction, values| puts "Transaction: #{transaction.to_s}: #{values.to_s}"}
  puts '=================='
  puts 'Association Rules'
  puts '=================='

  # create new Apriori ItemSet
  item_set = Apriori::ItemSet.new(data_set)

  # mine item set to produce association rules
  association_rules = item_set.mine(min_support.to_i,min_confidence.to_i)

  # print out association rules
  association_rules.each do |name, rule|
    puts name
    puts "Support: #{rule[0]}%, Confidence: #{rule[1]}%"
    puts '----------'
  end
end
