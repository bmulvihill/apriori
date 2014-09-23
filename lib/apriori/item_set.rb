module Apriori
  class ItemSet
    attr_reader :data_set, :iteration, :min_support, :min_confidence

    def initialize(data_set)
      @data_set = data_set
    end

    def create_frequent_item_sets min_support
      @min_support = min_support
      @iteration = 0
      while candidates.any?
        @iteration += 1
        @candidates = list.make_candidates
        frequent_item_sets << list unless iteration == 1
      end
      frequent_item_sets
    end

    def create_association_rules min_confidence
      rules ={}
      frequent_item_sets.each do |freq_lists|
        freq_lists.sets.each do |set|
          List.create_subsets(set).each do |combo|
            rule_name = "#{combo.join(',')}=>#{(set.flatten - combo.flatten).join(',')}"
            rules[rule_name] = confidence(combo.flatten, (set.flatten - combo.flatten))
          end
        end
      end
      rules.select{|k,v| v >= min_confidence}
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

    def candidates
      @candidates ||= convert_initial_data_set
    end

    def list
      @list ||= {}
      @list[iteration] ||= List.new(reject_candidates, iteration)
    end

    def frequent_item_sets
      @frequent_item_sets ||= []
    end
    
    def reject_candidates
      candidates.reject{|item| support(item) < min_support}
    end

    def convert_initial_data_set
      @data_set.values.flatten.uniq.map{|item| [item]}
    end
  end
end
