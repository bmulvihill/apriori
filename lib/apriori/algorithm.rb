require 'set'

module Apriori
  class Algorithm
    attr_reader :data_set, :candidates, :iteration
    attr_accessor :min_support, :min_confidence, :list

    def initialize(data_set)
      @data_set = data_set
      @list = List.new(convert_initial_data_set, iterate)
      @candidates = list.make_combination
    end

    def mine(min_support=0, min_confidence=0)
      @min_support, @min_confidence = min_support, min_confidence
      while !@candidates.empty?
        @candidates = list.make_combination
        @list = List.new(reject_candidates(candidates), iterate)
        frequent_sets << list unless iteration == 1
      end
    end

    def iterate
      @iteration ||= 0
      @iteration += 1
    end

    def frequent_sets
      @frequent_sets ||= []
    end

    def create_subsets set
      (1).upto(set.size - 1).flat_map { |n| set.combination(n).to_a }
    end

    def support item
      (count_frequency(item).to_f / data_set.size) * 100
    end

    def count_frequency set
      data_set.map do |transaction, items|
        contains_all?(items, set)
      end.reject {|item| item == false }.size
    end

    def confidence set1, set2
      support(set1 + set2) / support(set1) * 100
    end

    def contains_all? set, subset
      set.to_set.superset? subset.to_set
    end

    def reject_candidates candidates
      candidates.reject{|item| support(item) < min_support}
    end

    private

    def convert_initial_data_set
      @data_set.values.flatten.uniq
    end
  end
end
