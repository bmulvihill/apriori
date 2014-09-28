module Apriori
  class List
    attr_reader :sets, :set_size

    def initialize sets, set_size
      @sets = sets
      @set_size = set_size
    end

    def self.create_subsets set
      (1).upto(set.size - 1).flat_map { |n| set.combination(n).to_a }
    end

    def make_candidates
      if set_size <= 2
        sets.flatten.combination(set_size).to_a
      else
        self_join prune
      end
    end

    private

    def self_join set
      set.map{|a1| set.select{|a2| a1[0...-1] == a2[0...-1]}.flatten.uniq}.uniq
    end

    def prune
      sets.reject{|a1| sets.select{|a2| a1[0...-1] == a2[0...-1]}.size == 1}
    end

  end
end
