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
      create_association_rules
    end

    def iterate
      @iteration ||= 0
      @iteration += 1
    end

    def reject_candidates candidates
      candidates.reject{|item| item_set.support(item) < min_support}
    end

    def create_association_rules frequent_item_sets
      rules = {}
      frequent_item_sets.each do |freq_list|
        freq_list.create_subsets.each do |sub_set|
          rules["#{sub_set.flatten.join(',')}=>#{(freq_list.list - sub_set).flatten.join(',')}"] = {}
          rules["#{sub_set.flatten.join(',')}=>#{(freq_list.list - sub_set).flatten.join(',')}"][:confidence] = item_set.confidence(sub_set.flatten, (freq_list.list - sub_set).flatten)
        end
      end
      rules
    end

    private

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

    def frequent_item_sets
      @frequent_item_sets ||= []
    end

    def list
      @list ||= {}
      @list[iteration] ||= List.new(reject_candidates(candidates), iteration)
    end

    def convert_initial_data_set
      @data_set.values.flatten.uniq.map{|item| [item]}
    end
  end
end
