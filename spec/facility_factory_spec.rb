require 'spec_helper'

RSpec.describe FacilityFactory do
  
  before(:each) do
    @facility_factory = FacilityFactory.new
  end

  it 'exists' do
    expect(@facility_factory).to be_an_instance_of(FacilityFactory)
    
    #@co_dmv_office_locations is an array of hashes, where each hash represents an individual facility record
    #from the Colorado DMV Office Locations external data source
    @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations

    expect(@co_dmv_office_locations).to be_an(Array)
    expect(@co_dmv_office_locations[0][:dmv_office]).to eq("DMV Tremont Branch")
    expect(@co_dmv_office_locations[0][:phone]).to eq("(720) 865-4600")
    expect(@co_dmv_office_locations[0][:address_li]).to eq("2855 Tremont Place")
    expect(@co_dmv_office_locations[0][:address__1]).to eq("Suite 118")
    expect(@co_dmv_office_locations[0][:city]).to eq("Denver")
    expect(@co_dmv_office_locations[0][:state]).to eq("CO")
    expect(@co_dmv_office_locations[0][:zip]).to eq("80205")

    #printing return value for the first element in the @co_dmv_office_locations array to make sure it works
    #p @co_dmv_office_locations[0]
    #=> {:the_geom=>{:type=>"Point", :coordinates=>[-104.97443112500002, 39.75525297420336]}, :dmv_id=>"1", :dmv_office=>"DMV Tremont Branch",
    # :address_li=>"2855 Tremont Place", :address__1=>"Suite 118", :city=>"Denver", :state=>"CO", :zip=>"80205", :phone=>"(720) 865-4600",
    # :hours=>"Mon, Tue, Thur, Fri  8:00 a.m.- 4:30 p.m. / Wed 8:30 a.m.-4:30 p.m.", :services_p=>"vehicle titles, registration, renewals; VIN inspections",
    # :parking_no=>"parking available in the lot at the back of the bldg (Glenarm Street)", :photo=>"images/Tremont.jpg", :address_id=>"175164", :":@computed_region_nku6_53ud"=>"1444"}
    
    #printing the return value for all of the keys within the hash of the first facility record element in the @co_dmv_office_locations array to make sure the mapping logic is using the correct keys
    #p @co_dmv_office_locations[0].keys
    #=> [:the_geom, :dmv_id, :dmv_office, :address_li, :address__1, :city, :state, :zip, :phone, :hours, :services_p, :parking_no, :photo, :address_id, :":@computed_region_nku6_53ud"]

    #printing the return value for all of the keys used by any hash within the array of facility hashes to make sure I am accounting for multiple address lines or other differences that may exist between first element and others
    #p @co_dmv_office_locations.flat_map { |facility_record| facility_record.keys }.uniq
    #=> [:the_geom, :dmv_id, :dmv_office, :address_li, :address__1, :city, :state, :zip, :phone, :hours, :services_p, :parking_no, :photo, :address_id, :":@computed_region_nku6_53ud", :location]
  end
  
  it 'has the expected raw address data in the external dataset needed for transformation' do
    @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
    @facilities = @facility_factory.create_facilities(@co_dmv_office_locations)

    raw_location_data = @co_dmv_office_locations[0]

    expect(raw_location_data[:address_li]).to eq("2855 Tremont Place")
    expect(raw_location_data[:address__1]).to eq("Suite 118")
    expect(raw_location_data[:city]).to eq("Denver")
    expect(raw_location_data[:state]).to eq("CO")
    expect(raw_location_data[:zip]).to eq("80205")
    
  end

  it 'builds a full address string from the raw using the full_address helper method' do
    @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
    @facilities = @facility_factory.create_facilities(@co_dmv_office_locations)

    raw_location_data = @co_dmv_office_locations[0]
    
    expect(@facility_factory.full_address(raw_location_data)).to eq("#{@co_dmv_office_locations[0][:address_li]} #{@co_dmv_office_locations[0][:address__1]} #{@co_dmv_office_locations[0][:city]} #{@co_dmv_office_locations[0][:state]} #{@co_dmv_office_locations[0][:zip]}")
    expect(@facility_factory.full_address(raw_location_data)).to eq("2855 Tremont Place Suite 118 Denver CO 80205")
  end

  it 'correctly creates facility objects with transformed address from external sources raw data' do
    @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
    @facilities = @facility_factory.create_facilities(@co_dmv_office_locations)

    expect(@facilities).to be_an(Array)
    expect(@facilities[0]).to be_a(Facility)
    
    expect(@facilities[0].name).to eq(@co_dmv_office_locations[0][:dmv_office])
    expect(@facilities[0].phone).to eq(@co_dmv_office_locations[0][:phone])
    expect(@facilities[0].address).to eq("2855 Tremont Place Suite 118 Denver CO 80205")
    
    #p @facilities[0]
    #=> #<Facility:0x0000000105e924a0 @name="DMV Tremont Branch", @address="2855 Tremont Place Suite 118 Denver CO 80205", @phone="(720) 865-4600", @services=[], @registered_vehicles=[], @collected_fees=0>
  end

  describe 'Colorado facility data' do
    
    before(:each) do
      @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
      @colorado_facilities = @facility_factory.create_co_facilities(@co_dmv_office_locations)
    end

    it 'creates CO facility objects correctly' do
      expect(@colorado_facilities).to be_an(Array)
      expect(@colorado_facilities[0]).to be_a(Facility)
    end

    it 'transforms address data correctly' do
      raw_location_data = @co_dmv_office_locations[0]
      
      full_address = "#{raw_location_data[:address_li]} #{raw_location_data[:address__1]} #{raw_location_data[:city]} #{raw_location_data[:state]} #{raw_location_data[:zip]}"
      
      expect(@colorado_facilities[0].address).to eq(full_address)

      #p @colorado_facilities[0]
      #=> #<Facility:0x0000000105e924a0 @name="DMV Tremont Branch", @address="2855 Tremont Place Suite 118 Denver CO 80205", @phone="(720) 865-4600", @services=[], @registered_vehicles=[], @collected_fees=0>
    end
  end

  describe 'New York facility data' do
    
    before(:each) do
      @ny_dmv_office_locations = DmvDataService.new.ny_dmv_office_locations
      
      #printing return value for the first element in the @ny_dmv_office_locations array to make sure it works
      #p @ny_dmv_office_locations[0]
      #=> {:office_name=>"LAKE PLACID", :office_type=>"COUNTY OFFICE", :street_address_line_1=>"2693 MAIN STREET", :city=>"LAKE PLACID", :state=>"NY", :zip_code=>"12946",
      # :monday_beginning_hours=>"CLOSED", :monday_ending_hours=>"CLOSED", :georeference=>{:type=>"Point", :coordinates=>[-73.98278, 44.28213]}, :":@computed_region_yamh_8v7k"=>"430", 
      # :":@computed_region_wbg7_3whc"=>"275", :":@computed_region_kjdx_g34t"=>"2084"}

      @new_york_facilities = @facility_factory.create_ny_facilities(@ny_dmv_office_locations)
    end

    it 'creates NY facility objects correctly' do
      expect(@new_york_facilities).to be_an(Array)
      expect(@new_york_facilities[0]).to be_a(Facility)
  
      #printing the return value for all of the keys within the hash of the first facility record element in the @ny_dmv_office_locations array to make sure the mapping logic is using the correct keys
      #p @ny_dmv_office_locations[0].keys
      #=> [:office_name, :office_type, :street_address_line_1, :city, :state, :zip_code, :monday_beginning_hours, :monday_ending_hours,
      # :georeference, :":@computed_region_yamh_8v7k", :":@computed_region_wbg7_3whc", :":@computed_region_kjdx_g34t"]

      #printing the return value for all of the keys used by any hash within the array of facility hashes to make sure I am accounting for multiple address lines or other differences that may exist between first element and others
      #p @ny_dmv_office_locations.flat_map { |facility_record| facility_record.keys }.uniq
      # => [:office_name, :office_type, :street_address_line_1, :city, :state, :zip_code, :monday_beginning_hours, :monday_ending_hours,
      # :georeference, :":@computed_region_yamh_8v7k", :":@computed_region_wbg7_3whc", :":@computed_region_kjdx_g34t", :public_phone_number,
      # :tuesday_beginning_hours, :tuesday_ending_hours, :wednesday_beginning_hours, :wednesday_ending_hours, :thursday_beginning_hours, :thursday_ending_hours,
      # :friday_beginning_hours, :friday_ending_hours, :street_address_line_2, :public_phone_extension, :saturday_beginning_hours, :saturday_ending_hours]
    end

    it 'transforms address data correctly' do
      raw_location_data = @ny_dmv_office_locations[0]
     
      full_address = "#{raw_location_data[:street_address_line_1]} #{raw_location_data[:city]} #{raw_location_data[:state]} #{raw_location_data[:zip_code]}"
      
      expect(@new_york_facilities[0].address).to eq(full_address)
      
      #p @new_york_facilities[0]
      #=> <Facility:0x0000000103c8f970 @name="LAKE PLACID", @address="2693 MAIN STREET  LAKE PLACID NY 12946", @phone=nil, @services=[], @registered_vehicles=[], @collected_fees=0>
    end
  end

  describe 'Missouri facility data' do
    
    before(:each) do
      @mo_dmv_office_locations = DmvDataService.new.mo_dmv_office_locations
      
      #printing return value for the first element in the @mo_dmv_office_locations array to make sure it works
      #p @mo_dmv_office_locations[0]
      #=> {:number=>"032", :type=>"1MV", :name=>"Sarcoxie", :address1=>"111 N 6th", :city=>"Sarcoxie", :state=>"MO", :zipcode=>"64862", :phone=>"(417) 548-7332", :fax=>"(417) 548-3108",
      # :size=>"2", :email=>"sarcoxie.licenseoffice@lo.mo.gov", :agent=>"City of Sarcoxie", :officemanager=>"Heather Swan", :contractmanager=>"Don Triplett",
      # :daysopen=>"Monday & Friday 8:30-5:00, Tuesday - Thursday 8:30-4:30", :daysclosed=>"Monday & Friday 1:00-1:30",
      # :holidaysclosed=> "New Year's (1/1/2025), Martin Luther King Jr. Day (1/20/2025), Washington's Birthday (2/17/2025), Memorial Day (5/26/2025), Independence Day (7/4/2025), Labor Day (9/1/2025), Veteran's Day (11/11/2025), Thanksgiving Day (11/27/2025), Christmas Day (12/25/2025)",
      # :additionaldaysclosed=>"4/18/2025, 1/10/2025, 2/18/2025, 2/19/2025, 3/17/2025", :latlng=>{:latitude=>"37.0686822", :longitude=>"-94.1163988"},
      # :":@computed_region_ny2h_ckbz"=>"410", :":@computed_region_c8ar_jsdj"=>"94", :":@computed_region_ikxf_gfzr"=>"1966"}

      @missouri_facilities = @facility_factory.create_mo_facilities(@mo_dmv_office_locations)
    end

    it 'creates MO facility objects correctly' do
      expect(@missouri_facilities).to be_an(Array)
      expect(@missouri_facilities[0]).to be_a(Facility)

      #printing the return value for all of the keys within the hash of the first facility record element in the @mo_dmv_office_locations array to make sure the mapping logic is using the correct keys
      #p @mo_dmv_office_locations[0].keys
      #=> [:number, :type, :name, :address1, :city, :state, :zipcode, :phone, :fax, :size, :email, :agent, :officemanager, :contractmanager,
      # :daysopen, :daysclosed, :holidaysclosed, :additionaldaysclosed, :latlng, :":@computed_region_ny2h_ckbz", :":@computed_region_c8ar_jsdj", :":@computed_region_ikxf_gfzr"]

      #printing the return value for all of the keys used by any hash within the array of facility hashes to make sure I am accounting for multiple address lines or other differences that may exist between first element and others
      #p @mo_dmv_office_locations.flat_map { |facility_record| facility_record.keys }.uniq
      #=> [:number, :type, :name, :address1, :city, :state, :zipcode, :phone, :fax, :size, :email, :agent, :officemanager, :contractmanager, :daysopen, :daysclosed, :holidaysclosed, :additionaldaysclosed,
      # :latlng, :":@computed_region_ny2h_ckbz", :":@computed_region_c8ar_jsdj", :":@computed_region_ikxf_gfzr", :facebook_url, :managercontactnumber, :othercontactinfo, :dorregionnumber, :remarks, :additional_license_office_info]
    end

    it 'transforms address data correctly' do
      raw_location_data = @mo_dmv_office_locations[0]
      
      full_address = "#{raw_location_data[:address1]} #{raw_location_data[:city]} #{raw_location_data[:state]} #{raw_location_data[:zipcode]}"
      
      expect(@missouri_facilities[0].address).to eq(full_address)

      #p @missouri_facilities[0]
      #=> #<Facility:0x00000001042a8bb8 @name="Sarcoxie", @address="111 N 6th  Sarcoxie MO 64862", @phone="(417) 548-7332", @services=[], @registered_vehicles=[], @collected_fees=0>

    end
  end


end