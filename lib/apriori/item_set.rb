module Apriori
  class ItemSet
    attr_reader :data_set, :min_support, :min_confidence, :candidates

    def initialize(data_set)
      @data_set = data_set
    end

    def mine(min_support=0, min_confidence=0)
      @min_support, @min_confidence = min_support, min_confidence
      create_frequent_item_sets(min_support)
      create_association_rules(min_confidence)
    end

    def create_frequent_item_sets min_support
      @min_support = min_support
      make_item_sets unless frequent_item_sets.any?
      frequent_item_sets
    end

    def create_association_rules min_confidence
      frequent_item_sets.each do |freq_lists|
        freq_lists.sets.each do |set|
          List.create_subsets(set).each do |combo|
            rule_name = "#{combo.join(',')}=>#{(set.flatten - combo.flatten).join(',')}"
            association_rules[rule_name] ||= confidence(combo.flatten, (set.flatten - combo.flatten))
          end
        end
      end
      association_rules.select{|name, confidence| confidence >= min_confidence}
    end

    def support item
      (count_frequency(item).to_f / data_set.size) * 100
    end

    def confidence set1, set2
      (support(set1 + set2) / support(set1)) * 100
    end

    def count_frequency set
      data_set.map do |transaction, items|
        contains_all?(items, set)
      end.reject {|item| item == false }.size
    end

    def contains_all? set, subset
      set.to_set.superset? subset.to_set
    end

    private

    def make_item_sets
      @candidates = initial_data_set
      iteration = 0
      while candidates.any?
        iteration += 1
        list = List.new(reject_candidates, iteration)
        frequent_item_sets << list unless iteration == 1
        @candidates = list.make_candidates
      end
    end

    def association_rules
      @association_rules ||= {}
    end

    def frequent_item_sets
      @frequent_item_sets ||= {}
      @frequent_item_sets[min_support] ||= []
    end

    def reject_candidates
      candidates.reject{|item| support(item) < min_support}
    end

    def initial_data_set
      @initial_data_set ||= @data_set.values.flatten.uniq.map{|item| [item]}
    end
  end
end
