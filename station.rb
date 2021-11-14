require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_reader :name, :trains
  
  @@stations = []
  def self.all
    @@stations
  end
  
  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations.push(self)
    
  end
  
  def each_train
    trains.each{|train| yield(train)
  end
  
  def add_train(train)
    trains << train
  end
  
  def del_train(train)
    trains.delete(train)
  end
  
  def get_trains_type(train_type)
    trains.select{|x|x.train_type == train_type}
  end
   
  def valid?
    validate!
    true
  rescue
    false
    
  protected
  
  def validate!
    raise TypeError.new("Station name must be String")
      if !name.instance_of? String
  end
end
