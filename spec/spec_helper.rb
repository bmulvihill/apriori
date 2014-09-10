require 'factory_girl'
Dir["./lib/*.rb"].each {|file| require file}

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  FactoryGirl.find_definitions
end
