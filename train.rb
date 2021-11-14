require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter
  attr_reader :number, :route, :wagons, :speed
  
  @@trains = []
  
  def self.find(number)
    @@trains.select{|train|train.number == number}.first
  end

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    @route = nil
    @current_station_index = nil
    validate!
    @@trains.push(self)
    register_instance
    
  end
  
  def speed_up(value)
    @speed += value
  end
  
  def speed_stop
    @speed = 0
  end
  
  def add_wagon
    add_wagon!(wagon) 
  end
  
  def del_wagon
    wagons.pop  if speed = 0 && wagons.size > 0
  end
  
  def add_route(route)
    @route = route
    @current_station_index = 0
  end
  
  def move_forward
    @current_station_index += 1 if @current_station_index < route.stations.size
    end
 
  
  def move_backward
    @current_station_index -= 1 if @current_station_index > 0
  end
  
  def get_current_station
      route.stations[@current_station_index]
  end
  
  def get_next_station
     route.stations[@current_station_index + 1]
  end
  
  def get_prev_station
     route.stations[@current_station_index - 1]
  end
  
  def valid?
    validate!
    true
  rescue
    false 
  end
  
  protected
  
  def validate!
    errors = []
    
    errors << "Invalid number length.Available length of 5 on 6" 
      if self.number.length > 6 || self.number.length < 5
    errors << "Invalid number format.Use XXX-XX or XXXXX" 
      if self.number!~/^[\w\d]{3}-?[\w\d]{2}$/ 
      
    raise errors.join(";") unless errors.empty?
  end
  
  def type
     'unset'
  end
  
  def add_wagon!(wagon)
    wagons.push(wagon) if wagon.type == type
  end
  
  def each_wagon
    wagons.each{|wagon| yield(wagon)
  end
end
