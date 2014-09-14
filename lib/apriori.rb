class Apriori
  attr_reader :min_support, :min_confidence, :data_set, :list, :iteration

  def initialize(data_set, min_support, min_confidence=0)
    @data_set = data_set
    @min_support = min_support
    @min_confidence = min_confidence
    self.list = create_new_list(convert_initial_data_set)
  end

  def frequent_sets
    @frequent_sets ||= []
  end

  def create_subsets set
    (1).upto(set.size - 1).flat_map { |n| set.combination(n).to_a }
  end

  def support item
    (count_frequency(item).to_f / data_set.size) * 100
  end

  def count_frequency set
    data_set.map do |transaction, items|
      contains_all?(items, set)
    end.reject {|item| item == false }.size
  end

  def confidence set1, set2
    support(set1 + set2) / support(set1) * 100
  end

  def mine(min_support=0, min_confidence=0)
    while !self.list.empty?
      candidates = retrieve_candidates(list)
      frequent_sets << candidates
      self.list = create_new_list(candidates)
    end
  end

  def contains_all? set, subset
    (set & subset).size == subset.size
  end

  def retrieve_candidates new_list
    new_list.reject{|item| support(item) < min_support}.map{|item| item.join(',')}
  end

  # i dont like this
  def iterate
    @iteration ||= 0
    @iteration += 1
  end

  def create_new_list candidates
    iterate
    make_combination candidates
  end

  def make_combination candidates
    if iteration <= 2
      candidates.combination(iteration).to_a
    else
      self_join prune candidates.map{|c1| c1.split(',')}
    end
  end

  def self_join candidates
    candidates.map {|a1| candidates.select{|a2| a1[0...-1] == a2[0...-1]}.flatten.uniq}.uniq
  end

  def prune candidates
    candidates.reject{|a1| candidates.select{|a2| a1[0...-1] == a2[0...-1]}.size == 1}
  end

  private
  attr_writer :list, :matching_rules

  def convert_initial_data_set
    @data_set.values.flatten.uniq
  end
end
