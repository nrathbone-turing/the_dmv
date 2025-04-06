class FacilityFactory
  def create_facilities(external_dataset)
    # Iterates over each facility record (note that each one is already a hash)
    # and transforms it into a Facility object using the values from the hash
    external_dataset.map do |facility_record|
      Facility.new({
      :name => facility_record[:dmv_office],
      :address => full_address(facility_record),
      :phone => facility_record[:phone]
      })
    end
  end

  # Combines individual address components from the facility hash into a single string that matches the format expected by the Facility class
  # This parameter is named differently from the block variable above to reinforce that each method has a single, distinct responsibility (SRP),
  # even though they both reference the same kind of data (a facility hash in this case)
  def full_address(raw_location_data)
    "#{raw_location_data[:address_li]} #{raw_location_data[:address__1]} #{raw_location_data[:city]} #{raw_location_data[:state]} #{raw_location_data[:zip]}"
  end

  #not sure if we need to do this or not, add services to our objects too or if just returning the above data is enough
  #it also seems that not all of the facilities have the services provided at that location in the external data set
  
  #transforms the hash key values from the facility record for services offered from a single string
  #into an array of strings that matches what the Facility class expects and can pass as a valid argument for the :services parameter
  # def transform_services(external_dataset)
    
  #   transform_services(@facility_record).split(' ')
  #   transform_services(@facility_record[:services_p]).each do |service|
  #     facility.add_service(service)
  #   end
  # end


end