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
    return nil unless services.include?('Vehicle Registration')
    
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

  def administer_written_test(registrant)
    return false unless services.include?('Written Test')
    return false unless registrant.age >= 16
    return false unless registrant.permit? == true
    
    registrant.license_data[:written] = true
    return true
  end

  def administer_road_test(registrant)
    return false unless services.include?('Road Test')
    return false unless registrant.license_data[:written] == true
    
    registrant.license_data[:license] = true
    return true
  end

  def renew_drivers_license(registrant)
    return false unless services.include?('Renew License')
    return false unless registrant.license_data[:written] == true
    return false unless registrant.license_data[:license] == true
    
    registrant.license_data[:renewed] = true
    return true
  end


end