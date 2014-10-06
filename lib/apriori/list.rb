module Apriori
  class List
    attr_reader :sets

    # class method to create all subsets of given set
    def self.create_subsets set
      (1).upto(set.size - 1).flat_map { |n| set.combination(n).to_a }
    end

    # intialize list with frequent item sets
    def initialize sets
      @sets = sets
    end

    # returns the size of the item sets
    def size
      return 0 if sets.empty?
      sets.first.size
    end

    # makes all candidates for the next list (size + 1)
    def make_candidates
      if (size + 1) <= 2
        sets.flatten.combination(size + 1).to_a
      else
        self_join(prune)
      end
    end

    private

    # performs a self join when creating new candidates, requires a pruned set
    def self_join set
      set.map{|a1| set.select{|a2| a1[0...-1] == a2[0...-1]}.flatten.uniq}.uniq
    end

    # prunes the frequent item sets before doing a self join
    def prune
      sets.reject{|a1| sets.select{|a2| a1[0...-1] == a2[0...-1]}.size == 1}
    end

  end
end
