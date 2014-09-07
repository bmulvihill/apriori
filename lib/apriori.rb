class Apriori
  attr_reader :min_support, :min_confidence, :data_set
  attr_accessor :list, :matching_rules

  def initialize(data_set, min_support, min_confidence=0)
    @data_set = data_set
    @min_support = min_support
    @min_confidence = min_confidence
    @size = 0
    @list = create_new_list(convert_initial_data_set)
  end

  # development notes
  # loop until the list is empty
  # count frequency of items in list
  # get candiates, by determining if they meet minimum support
  # add all matching candidates to possible association rules
  # create a new list
  def mine
    while !list.empty?
      new_list = count_frequency(list)
      candidates = retrieve_candidates(new_list)
      list = create_new_list(candidates)
    end
  end

  def count_frequency set
    list = {}
    data_set.each do |transaction, items|
      set.each do |set_items|
        list[set_items.join(',')] ||= 0
        list[set_items.join(',')] += 1 unless (items & set_items).empty?
      end
    end
    list
  end

  def retrieve_candidates list
    list.reject!{|key, value| (value.to_f/data_set.count) * 100 < min_support}.keys
  end

  def create_new_list candidates
    @size += 1
    candidates.combination(@size).to_a
  end

  private
  def convert_initial_data_set
    @data_set.values.flatten.uniq
  end
end
