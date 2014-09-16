require 'set'

module Apriori
  class Algorithm
    attr_reader :data_set, :candidates, :iteration
    attr_accessor :min_support, :min_confidence

    def initialize(data_set)
      @data_set = data_set
      @candidates = create_new_candidates(convert_initial_data_set)
    end

    def mine(min_support=0, min_confidence=0)
      @min_support, @min_confidence = min_support, min_confidence
      while !@candidates.empty?
        list = retrieve_list(candidates)
        frequent_sets << list unless iteration == 1
        @candidates = create_new_candidates(list)
      end
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

    def retrieve_list list
      list.reject{|item| support(item) < min_support}
    end

    # i dont like this
    def iterate
      @iteration ||= 0
      @iteration += 1
    end

    def create_new_candidates list
      iterate
      make_combination list
    end

    def make_combination list
      if iteration <= 2
        list.flatten.combination(iteration).to_a
      else
        self_join prune list
      end
    end

    def self_join list
      list.map {|a1| list.select{|a2| a1[0...-1] == a2[0...-1]}.flatten.uniq}.uniq
    end

    def prune list
      list.reject{|a1| list.select{|a2| a1[0...-1] == a2[0...-1]}.size == 1}
    end

    private
    #attr_accessor :list

    def convert_initial_data_set
      @data_set.values.flatten.uniq
    end
  end
end
