class Apriori
  attr_reader :min_support, :min_confidence, :data_set
  attr_accessor :list

  def initialize(data_set, min_support, min_confidence=0)
    @data_set = data_set
    @min_support = min_support
    @min_confidence = min_confidence
    @size = 0
    @list = create_new_set(convert_initial_data_set)
  end

  def mine
    #list = create_new_set(data_set)
    #candidates = count_frequency (data_set)
    #remove_candidates(candidates)
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

  def create_new_set candidates
    @size += 1
    candidates.combination(@size).to_a
  end

  private
  def convert_initial_data_set
    @data_set.values.flatten.uniq
  end
end
