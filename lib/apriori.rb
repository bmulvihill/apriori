class Apriori
  attr_reader :min_support, :min_confidence, :data_set, :list, :matching_rules, :iteration

  def initialize(data_set, min_support, min_confidence=0)
    @data_set = data_set
    @min_support = min_support
    @min_confidence = min_confidence
    self.list = create_new_list(convert_initial_data_set)
  end

  # development notes
  # loop until the list is empty
  # count frequency of items in list
  # get candiates, by determining if they meet minimum support
  # add all matching candidates to possible association rules
  # create a new list
  def mine(min_support=0, min_confidence=0)
    while !self.list.empty?
      new_list = count_frequency(list)
      candidates = retrieve_candidates(new_list)
      self.list = create_new_list(candidates)
    end
  end

  def count_frequency sub_set
    counters = {}
    data_set.each do |transaction, items|
      sub_set.each do |sub_set_items|
        counters[sub_set_items.join(',')] ||= 0
        counters[sub_set_items.join(',')] += 1 if contains_all?(items, sub_set_items)
      end
    end
    counters
  end

  # dev note
  # move to mixin / helper?
  def contains_all? set, subset
    (set & subset).count == subset.count
  end

  def retrieve_candidates new_list
    new_list = new_list.reject{|key, value| (value.to_f/data_set.count) * 100 < min_support}
    new_list.keys
  end

  def iterate
    @iteration ||= 0
    @iteration += 1
  end

  # need to implement self join here
  def create_new_list candidates
    iterate
    candidates = prune candidates if iteration > 2
    candidates.map{|c| c.split(',')}.flatten.uniq.combination(iteration).to_a
  end

  def prune candidates
    c = candidates.map{|c| c.split(',')}
    c = c.map{|candidate| candidate[0...-1]}.flatten #flatten array of pairs
    c = c.inject(Hash.new(0)) {|item,count| item[count]+=1;item} # count occurances of each item
    candidates.reject{|candidate| c[candidate.split(',')[0...-1].join(',')] < 2 } # removes those items with less than 2
  end

  private
  attr_writer :list, :matching_rules

  def convert_initial_data_set
    @data_set.values.flatten.uniq
  end
end
