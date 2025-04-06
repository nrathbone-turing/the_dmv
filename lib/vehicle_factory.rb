class VehicleFactory

  #this method takes a collection of individual vehicle records from the external data source
  #(stored as an array of hashes) and maps each vehicle record to a new instance of the corresponding Vehicle class,
  #then returns an array of these new Vehicle object instances
  def create_vehicles(external_dataset)
    
    #create a hash for each new vehicle object with keys that my existing Vehicle class will expects (a hash of vehicle attributes)
    #and that hash is then passed into Vehicle.new(...) and becomes the vehicle_details values used initialize a new instance of a Vehicle object
    external_dataset.map do |vehicle_record|
      Vehicle.new({
      :vin => vehicle_record[:vin_1_10],
      :year => vehicle_record[:model_year],
      :make => vehicle_record[:make],
      :model => vehicle_record[:model],
      :engine => :ev
    })
    end
  end


end