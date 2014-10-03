module Apriori
  class List
    attr_reader :sets

    def initialize sets
      @sets = sets
    end

    def self.create_subsets set
      (1).upto(set.size - 1).flat_map { |n| set.combination(n).to_a }
    end

    def make_candidates
      if candidate_size <= 2
        sets.flatten.combination(candidate_size).to_a
      else
        self_join prune
      end
    end

    private

    def candidate_size
      if sets.first.is_a?(Array)
        sets.first.size + 1
      else
        0
      end
    end

    def self_join set
      set.map{|a1| set.select{|a2| a1[0...-1] == a2[0...-1]}.flatten.uniq}.uniq
    end

    def prune
      sets.reject{|a1| sets.select{|a2| a1[0...-1] == a2[0...-1]}.size == 1}
    end

  end
end
