class Facility
  attr_reader :name, :address, :phone, :services, :collected_fees

  def initialize(facility)
    @name = facility[:name]
    @address = facility[:address]
    @phone = facility[:phone]
    @services = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end
end

def register_vehicle(vehicle)
  
  @registration_date = Date.today

  if vehicle.antique? == true
    @collected_fees + 25
    @plate_type[:antique]
    @registered_vehicles << vehicle
    
  elsif vehicle.electric_vehicle? == true
    @collected_fees + 200
    @plate_type[:ev]
    @registered_vehicles << vehicle
  
  else vehicle
    @collected_fees + 100
    @plate_type[:basic]
    @registered_vehicles << vehicle
  end
end