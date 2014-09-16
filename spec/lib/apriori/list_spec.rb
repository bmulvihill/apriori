describe Apriori::List do
  context '#make_combination' do
    it 'will return all combinations for first two iterations' do
      array =['Hi1','Hi2','Hi3']
      @list = Apriori::List.new(array,2)
      expect(@list.make_combination).to eql([['Hi1','Hi2'],['Hi1','Hi3'],['Hi2','Hi3']])
    end

    it 'will return the self join after the first two iterations' do
      array = [['Hi1','Hi2'], ['Hi1','Hi3'], ['Blah1', 'Blah2'], ['Blah1', 'Blah3']]
      @list = Apriori::List.new(array,3)
      expect(@list.make_combination).to eql([['Hi1','Hi2','Hi3'],['Blah1','Blah2','Blah3']])
    end

    it 'will prune elements' do
      array = [['Hi1','Hi2'], ['Hi1','Hi3'], ['Blah1', 'Blah2'], ['Blah1', 'Blah3'], ['Blarg1', 'Blarg2']]
      @list = Apriori::List.new(array,3)
      expect(@list.make_combination).to eql([['Hi1','Hi2','Hi3'],['Blah1','Blah2','Blah3']])
    end
  end
end
