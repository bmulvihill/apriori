module Apriori
  class ItemSet
    attr_reader :data_set

    def initialize(data_set)
      @data_set = data_set
    end

    def support item
      (count_frequency(item).to_f / data_set.size) * 100
    end

    def confidence set1, set2
      support(set1 + set2) / support(set1) * 100
    end

    def count_frequency set
      data_set.map do |transaction, items|
        contains_all?(items, set)
      end.reject {|item| item == false }.size
    end

    def contains_all? set, subset
      set.to_set.superset? subset.to_set
    end

  end
end
