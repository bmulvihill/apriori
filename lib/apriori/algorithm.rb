require 'set'

module Apriori
  class Algorithm
    attr_reader :data_set, :item_set, :candidates, :iteration
    attr_accessor :min_support, :min_confidence, :list

    def initialize(data_set)
      @data_set = data_set
      @candidates = convert_initial_data_set
    end

    def mine(min_support=0, min_confidence=0)
      @min_support, @min_confidence = min_support, min_confidence
      while !@candidates.empty?
        iterate
        @candidates = list.make_candidates
      end
    end

    def iterate
      @iteration ||= 0
      @iteration += 1
    end

    def frequent_sets
      @frequent_sets ||= []
    end

    def reject_candidates candidates
      candidates.reject{|item| item_set.support(item) < min_support}
    end

    private

    def item_set
      @item_set ||= ItemSet.new(data_set)
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
