require 'set'

module Apriori
  class Algorithm
    attr_accessor :min_support, :min_confidence, :item_set

    def initialize(item_set)
      @item_set = item_set
    end

    def mine(min_support=0, min_confidence=0)
      @min_support, @min_confidence = min_support, min_confidence
      item_set.create_frequent_item_sets(min_support)
      item_set.create_association_rules(min_support, min_confidence)
    end

  end
end
