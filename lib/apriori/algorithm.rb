require 'set'

module Apriori
  class Algorithm
    attr_reader :data_set, :item_set, :candidates, :iteration
    attr_accessor :min_support, :min_confidence

    def initialize(data_set)
      @data_set = data_set
      @candidates = convert_initial_data_set
    end

    def mine(min_support=0, min_confidence=0)
      @min_support, @min_confidence = min_support, min_confidence
      create_frequent_item_sets
      item_set.create_association_rules(frequent_item_sets)
    end

    private

    def iterate
      @iteration ||= 0
      @iteration += 1
    end

    def create_frequent_item_sets
      while @candidates.any?
        iterate
        @candidates = list.make_candidates
        frequent_item_sets << list unless iteration == 1
      end
    end

    def item_set
      @item_set ||= ItemSet.new(data_set)
    end

    def list
      @list ||= {}
      @list[iteration] ||= List.new(new_list, iteration)
    end

    def new_list
      item_set.reject_candidates(candidates, min_support)
    end

    def frequent_item_sets
      @frequent_item_sets ||= []
    end

    def convert_initial_data_set
      @data_set.values.flatten.uniq.map{|item| [item]}
    end
  end
end
