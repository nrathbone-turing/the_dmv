class Facility
  attr_reader :name,
              :address,
              :phone,
              :services,
              :registered_vehicles,
              :collected_fees

  def initialize(facility)
    @name = facility[:name]
    @address = facility[:address]
    @phone = facility[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    
    if vehicle.antique? == true
      @collected_fees += 25
      vehicle.plate_type = :antique
            
    elsif vehicle.electric_vehicle? == true
      @collected_fees += 200
      vehicle.plate_type = :ev
          
    else
      @collected_fees += 100
      vehicle.plate_type = :regular
    end

    vehicle.registration_date = Date.today
    @registered_vehicles << vehicle
  end
end