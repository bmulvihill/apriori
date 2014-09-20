describe Apriori::Algorithm do
  before do
    @apriori = FactoryGirl.build(:algorithm)
  end

  context '#mine' do
    it 'returns all association rules meeting the minimum support and confidence' do
      @apriori.mine(50)
    end
  end

end
