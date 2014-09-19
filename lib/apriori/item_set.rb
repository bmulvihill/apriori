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

    def create_association_rules frequent_item_sets
      rules = {}
      frequent_item_sets.each do |freq_list|
        freq_list.create_subsets.each do |sub_set|
          rules["#{sub_set.flatten.join(',')}=>#{(freq_list.list - sub_set).flatten.join(',')}"] = {}
          rules["#{sub_set.flatten.join(',')}=>#{(freq_list.list - sub_set).flatten.join(',')}"][:confidence] = confidence(sub_set.flatten, (freq_list.list - sub_set).flatten)
        end
      end
      rules
    end

    def reject_candidates candidates, min_support
      candidates.reject{|item| support(item) < min_support}
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
