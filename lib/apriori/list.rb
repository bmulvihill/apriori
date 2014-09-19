module Apriori
  class List
    attr_reader :list, :iteration

    def initialize list, iteration
      @list = list
      @iteration = iteration
    end

    def make_candidates
      if iteration <= 2
        list.flatten.combination(iteration).to_a
      else
        self_join prune
      end
    end

    def create_subsets
      (1).upto(list.size - 1).flat_map { |n| list.combination(n).to_a }
    end

    private

    def self_join list
      list.map{|a1| list.select{|a2| a1[0...-1] == a2[0...-1]}.flatten.uniq}.uniq
    end

    def prune
      list.reject{|a1| list.select{|a2| a1[0...-1] == a2[0...-1]}.size == 1}
    end

  end
end
