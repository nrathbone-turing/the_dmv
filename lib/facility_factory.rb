class FacilityFactory
  def create_facilities(location, external_dataset)
    
    # Iterates over each facility record (note that each one is already a hash)
    # and transforms it into a Facility object using the values from the hash
    external_dataset.map do |facility_record|
      if location == "Colorado"
        
        # Combines individual address components from the facility hash into a single string that matches the format expected by the Facility class
        full_address = "#{facility_record[:address_li]} #{facility_record[:address__1]} #{facility_record[:city]} #{facility_record[:state]} #{facility_record[:zip]}"
        
        Facility.new({
          name: facility_record[:dmv_office],
          address: full_address,
          phone: facility_record[:phone]
        })
  
      elsif location == "New York"
        full_address = "#{facility_record[:street_address_line_1]} #{facility_record[:city]} #{facility_record[:state]} #{facility_record[:zip_code]}"
  
        Facility.new({
          name: facility_record[:office_name],
          address: full_address,
          phone: facility_record[:public_phone_number]
        })
  
      elsif location == "Missouri"
        full_address = "#{facility_record[:address1]} #{facility_record[:city]} #{facility_record[:state]} #{facility_record[:zipcode]}"
  
        Facility.new({
          name: facility_record[:name],
          address: full_address,
          phone: facility_record[:phone]
        })
      end
    end
  end
  

end
