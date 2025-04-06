class FacilityFactory
  def create_facilities(external_dataset)
    external_dataset.map do |facility_record|
      Facility.new({
      :name => facility_record[],
      :address => facility_record[],
      :phone => facility_record[],
      :services => facility_record[],
      :registered_vehicles => facility_record[],
      :collected_fees= => facility_record[]
      })
    end
  end


end