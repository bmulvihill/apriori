class Apriori
  attr_reader :min_frequency, :set

  def initialize(min_frequency, set)
    @min_frequency = min_frequency
    @set = set
  end

  def mine
    count_frequency(set)
  end

  def count_frequency candidates
    list = {}
    candidates.each do |transaction, items|
      items.uniq.each do |item|
        list[item.to_sym] ||= 0
        list[item.to_sym] += 1
      end
    end
    list
  end

end
