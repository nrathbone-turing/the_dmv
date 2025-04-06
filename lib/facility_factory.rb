class FacilityFactory
  def create_facilities(external_dataset)
    external_dataset.map do |facility_record|
      Facility.new({
      :name => facility_record[:dmv_office],
      :address => full_address(external_dataset),
      :phone => facility_record[:phone]
      })
    end
  end

  #combines the hash key values from the facility record that store individual components of an address from multiple strings
  #into a single string that matches what the Facility class expects and can pass as a valid argument for the :address parameter
  def full_address(external_dataset)
    "#{:address_li} #{:address_1} #{:city} #{:state} #{:zip}"
  end

  #transforms the hash key values from the facility record for services offered from a single string
  #into an array of strings that matches what the Facility class expects and can pass as a valid argument for the :services parameter
  def transform_services(external_dataset)
    transform_services(@facility_record[:services_p]).each do |service|
      facility.add_service(service)
    end
  end


end