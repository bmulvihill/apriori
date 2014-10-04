describe Apriori::List do
  context '#make_candidates' do
    it 'will return all combinations for first two iterations' do
      array =[['Hi1'],['Hi2'],['Hi3']]
      @list = Apriori::List.new(array)
      expect(@list.make_candidates).to eql([['Hi1','Hi2'],['Hi1','Hi3'],['Hi2','Hi3']])
    end

    it 'will return the self join after the first two iterations' do
      array = [['Hi1','Hi2'], ['Hi1','Hi3'], ['Blah1', 'Blah2'], ['Blah1', 'Blah3']]
      @list = Apriori::List.new(array)
      expect(@list.make_candidates).to eql([['Hi1','Hi2','Hi3'],['Blah1','Blah2','Blah3']])
    end

    it 'will prune elements' do
      array = [['Hi1','Hi2'], ['Hi1','Hi3'], ['Blah1', 'Blah2'], ['Blah1', 'Blah3'], ['Blarg1', 'Blarg2']]
      @list = Apriori::List.new(array)
      expect(@list.make_candidates).to eql([['Hi1','Hi2','Hi3'],['Blah1','Blah2','Blah3']])
    end
  end

  context '#self.create_subsets' do
    it 'returns nothing if the subset size is 1' do
      array = [[1],[2],[3]]
      expect(Apriori::List.create_subsets([1])).to eql([])
    end

    it 'returns all possible subsets of an array' do
      array = [[1,2,3]]
      expect(Apriori::List.create_subsets([1,2,3])).to eql([[1],[2],[3],[1,2],[1,3],[2,3]])
    end
  end

  context '#set_size' do
    it 'will return the size of the sets' do
      array = [['Hi1','Hi2'], ['Hi1','Hi3'], ['Blah1', 'Blah2'], ['Blah1', 'Blah3'], ['Blarg1', 'Blarg2']]
      @list = Apriori::List.new(array)
      expect(@list.size).to eql(2)
    end

    it 'will return zero if there is no sets' do
      array = []
      @list = Apriori::List.new(array)
      expect(@list.size).to eql(0)
    end
  end
end
