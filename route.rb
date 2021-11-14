require_relative 'instance_counter'

class Route
  include InstanceCounter
    attr_reader :stations
  
    def initialize(station_first,station_last)
      validate!
      @stations = [station_first,station_last]
      
   end
  
    def add_station(station)
       validate!
        stations.insert(-2, station)
    end
  
    def del_station(station)
       validate!
        stations.delete(station)
    end
    
    def valid?
      validate!
      true
    rescue
      false
    end
    
    protected 
    
    def validate!
      raise TypeError.new("Station must by type of Station")
        if !name.instanse_of? Station
    end
  end
