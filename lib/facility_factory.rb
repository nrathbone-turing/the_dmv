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

  #method for the facility factory using only the Colorado dataset
  def create_co_facilities(external_dataset)
    external_dataset.map do |facility_record|
      full_address = "#{facility_record[:address_li]} #{facility_record[:address__1]} #{facility_record[:city]} #{facility_record[:state]} #{facility_record[:zip]}"
      
      Facility.new({
      :name => facility_record[:dmv_office],
      :address => full_address,
      :phone => facility_record[:phone]
      })
    end
  end

  #method for the facility factory using only the New York dataset
  def create_ny_facilities(external_dataset)
    external_dataset.map do |facility_record|
      full_address = "#{facility_record[:street_address_line_1]} #{facility_record[:city]} #{facility_record[:state]} #{facility_record[:zip_code]}" 
      
      Facility.new({
        :name => facility_record[:office_name],
        :address => full_address,
        :phone => facility_record[:phone]
      })
    end
  end

  #method for the facility factory using only the Missouri dataset
  def create_mo_facilities(external_dataset)
    external_dataset.map do |facility_record|
      full_address = "#{facility_record[:address1]} #{facility_record[:city]} #{facility_record[:state]} #{facility_record[:zipcode]}"
      
      Facility.new({
      :name => facility_record[:name],
      :address => full_address,
      :phone => facility_record[:phone]
      })
    end
  end

end
