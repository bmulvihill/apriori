module Apriori
  class ItemSet
    # Getters
    attr_reader :data_set, :min_support, :min_confidence

    # Initialze ItemSet with a data hash of transactions
    def initialize(data_set)
      @data_set = data_set
    end

    ##### Public Methods ####

    # pass in support and confidence to mine data set
    def mine(min_support=0, min_confidence=0)
      @min_support, @min_confidence = min_support, min_confidence
      create_frequent_item_sets(min_support)
      create_association_rules(min_confidence)
    end

    # creates all frequent item sets in the data_set based on given minimum support
    def create_frequent_item_sets min_support
      @min_support = min_support
      make_item_sets unless frequent_item_sets.any?
      frequent_item_sets
    end

    # creates all association rules in the data set based on given confidence
    def create_association_rules min_confidence
      make_association_rules unless frequent_item_sets.empty?
      association_rules.select{ |name, confidence| confidence >= min_confidence }
    end

    # calculates the support of an item
    def support item
      (count_frequency(item).to_f / data_set.size) * 100
    end

    # calculates the confidence of an item set
    def confidence set1, set2
      (support(set1 + set2) / support(set1)) * 100
    end

    # counts the frequency of a set within the data set
    def count_frequency set
      data_set.map do |transaction, items|
        contains_all?(items, set)
      end.reject {|item| item == false }.size
    end

    ##### Private Methods #####
    private
    attr_reader :candidates

    # makes all the frequency item sets called by create_frequent_item_sets
    # creates candidates
    # creates new lists from each candidate set after rejecting candidates
    # stores lists within the frequent_item_sets hash
    # continues until there are no more candidates
    def make_item_sets
      @candidates = initial_data_set
      while candidates.any?
        list = List.new(reject_candidates)
        frequent_item_sets << list
        @candidates = list.make_candidates
      end
    end

    # creates all the association rules
    # iterates through frequent_item_sets of given minimum support
    # goes through each list within the set
    # goes through each set within the list and creates all subsets
    # creates a rule and calculates confidence of the rule
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

    # memoized hash to store all association rules
    # prevents repeated work from being done
    def association_rules
      @association_rules ||= {}
      @association_rules[min_support] ||= {}
    end

    # memoized hash of all frequent item sets
    # prevent repeated work from being done
    def frequent_item_sets
      @frequent_item_sets ||= {}
      @frequent_item_sets[min_support] ||= []
    end

    # helper method to determine if a set is a super set
    def contains_all? set, subset
      set.to_set.superset? subset.to_set
    end

    # helper method to reject all candiates below minimum support when creating a new list
    def reject_candidates
      candidates.reject{|item| support(item) < min_support}
    end

    # converts the initial hash into one item sets
    def initial_data_set
      @initial_data_set ||= @data_set.values.flatten.uniq.map{|item| [item]}
    end
  end
end
