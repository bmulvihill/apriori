describe Apriori::List do
  context '#make_candidates' do
    it 'will return all combinations for first two iterations' do
      array =['Hi1','Hi2','Hi3']
      @list = Apriori::List.new(array,2)
      expect(@list.make_candidates).to eql([['Hi1','Hi2'],['Hi1','Hi3'],['Hi2','Hi3']])
    end

    it 'will return the self join after the first two iterations' do
      array = [['Hi1','Hi2'], ['Hi1','Hi3'], ['Blah1', 'Blah2'], ['Blah1', 'Blah3']]
      @list = Apriori::List.new(array,3)
      expect(@list.make_candidates).to eql([['Hi1','Hi2','Hi3'],['Blah1','Blah2','Blah3']])
    end

    it 'will prune elements' do
      array = [['Hi1','Hi2'], ['Hi1','Hi3'], ['Blah1', 'Blah2'], ['Blah1', 'Blah3'], ['Blarg1', 'Blarg2']]
      @list = Apriori::List.new(array,3)
      expect(@list.make_candidates).to eql([['Hi1','Hi2','Hi3'],['Blah1','Blah2','Blah3']])
    end
  end

  context '#create_subsets' do
    it 'returns nothing if the subset size is 1' do
      array = [[1],[2],[3]]
      @list = Apriori::List.new(array,3)
      expect(@list.create_subsets).to eql([[],[],[]])
    end

    it 'returns all possible subsets of an array' do
      array = [[1,2,3]]
      @list = Apriori::List.new(array,3)
      expect(@list.create_subsets).to eql([[[1],[2],[3],[1,2],[1,3],[2,3]]])
    end
  end
end
