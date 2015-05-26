module Apriori
  class ItemSet
    attr_reader :transactions, :min_support, :min_confidence

    def initialize(transactions)
      @transactions = transactions
    end

    def mine(min_support=0, min_confidence=0)
      @min_support, @min_confidence, @candidates = min_support, min_confidence, nil
      create_frequent_item_sets(min_support)
      create_association_rules(min_confidence)
    end

    def create_frequent_item_sets min_support
      @min_support = min_support
      make_item_sets
      frequent_item_sets
    end

    def create_association_rules min_confidence
      make_association_rules unless frequent_item_sets.empty?
      association_rules.select{ |name, rule| rule >= min_confidence }
    end

    def support item
      (count_frequency(item).to_f / transactions.size) * 100
    end

    def confidence set1, set2
      (support(set1 + set2) / support(set1)) * 100
    end

    def count_frequency set
      transactions.map do |items|
        contains_all?(items, set)
      end.reject { |item| item == false }.size
    end

    private

    def candidates
      @candidates ||= transactions.flatten.uniq.map { |item| [item] }
    end

    def make_item_sets
      while candidates.any?
        list = List.new(new_candidates)
        frequent_item_sets << list
        @candidates = list.make_candidates
      end
    end

    def make_association_rules
      frequent_item_sets.each do |freq_lists|
        freq_lists.sets.each do |set|
          List.create_subsets(set).each do |combo|
            rule_name = "#{combo.join(',')}=>#{(set.flatten - combo.flatten).join(',')}"
            association_rules[rule_name] ||= confidence(combo.flatten, (set.flatten - combo.flatten))
          end
        end
      end
    end

    def association_rules
      @association_rules ||= {}
      @association_rules[min_support] ||= {}
    end

    def frequent_item_sets
      @frequent_item_sets ||= {}
      @frequent_item_sets[min_support] ||= []
    end

    def contains_all? set, subset
      set.to_set.superset? subset.to_set
    end

    def new_candidates
      candidates.reject{ |item| support(item) < min_support }
    end

  end
end
