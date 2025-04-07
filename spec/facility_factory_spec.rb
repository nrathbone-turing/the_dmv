require 'spec_helper'

RSpec.describe FacilityFactory do
  
  before(:each) do
    @facility_factory = FacilityFactory.new
  end

  describe '#create_facilities' do
  
    before(:each) do
      @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
      
      #for testing multiple elements at different index positions; this should avoid the first/last element and randomly pick one from the remaining elements
      #@random_middle_index = rand(1..ny.length - 2)
      #pry(main)> @random_middle_index
      #=> 2
      @random_middle_index = 2
    end

    it 'exists' do
      expect(@facility_factory).to be_an_instance_of(FacilityFactory)
    end
  end
  
  describe '#full_address helper method' do

    it 'builds a full address string from the raw using the full_address helper method' do
      @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
      
      raw_location_data = @co_dmv_office_locations[0]
      
      expect(@facility_factory.full_address(raw_location_data)).to eq("#{@co_dmv_office_locations[0][:address_li]} #{@co_dmv_office_locations[0][:address__1]} #{@co_dmv_office_locations[0][:city]} #{@co_dmv_office_locations[0][:state]} #{@co_dmv_office_locations[0][:zip]}")
      expect(@facility_factory.full_address(raw_location_data)).to eq("2855 Tremont Place Suite 118 Denver CO 80205")
    end    
  end
       
  describe 'raw Colorado DMV Office Locations data' do
    
    before(:each) do
      @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
      
      #for testing multiple elements at different index positions; this should avoid the first/last element and randomly pick one from the remaining elements
      #@random_middle_index = rand(1..@co_dmv_office_locations.length - 2)
      #pry(main)> @random_middle_index
      #=> 2
      @random_middle_index = 2
    end

    it 'is an array of facility hashes' do
      expect(@co_dmv_office_locations).to be_an(Array)
      
      #@co_dmv_office_locations is an array of hashes, where each hash represents an individual facility record
      #from the Colorado DMV Office Locations external data source
      
      #testing the return value for all of the keys used by any hash within the array of facility hashes to make sure I am accounting for multiple address lines or other differences that may exist between first element and others
      #pry(main)> @co_dmv_office_locations.flat_map { |facility_record| facility_record.keys }.uniq
      #=> [:the_geom, :dmv_id, :dmv_office, :address_li, :address__1, :city, :state, :zip, :phone, :hours, :services_p, :parking_no, :photo, :address_id, :":@computed_region_nku6_53ud", :location]
    end
    
    it 'contains expected values for the first facility_record element' do
      
      expect(@co_dmv_office_locations[0][:dmv_office]).to eq("DMV Tremont Branch")
      expect(@co_dmv_office_locations[0][:phone]).to eq("(720) 865-4600")
      expect(@co_dmv_office_locations[0][:address_li]).to eq("2855 Tremont Place")
      expect(@co_dmv_office_locations[0][:address__1]).to eq("Suite 118")
      expect(@co_dmv_office_locations[0][:city]).to eq("Denver")
      expect(@co_dmv_office_locations[0][:state]).to eq("CO")
      expect(@co_dmv_office_locations[0][:zip]).to eq("80205")
      
      #pry(main)> @co_dmv_office_locations[0]
      #=> {:the_geom=>{:type=>"Point", :coordinates=>[-104.97443112500002, 39.75525297420336]}, :dmv_id=>"1", :dmv_office=>"DMV Tremont Branch",
      # :address_li=>"2855 Tremont Place", :address__1=>"Suite 118", :city=>"Denver", :state=>"CO", :zip=>"80205", :phone=>"(720) 865-4600",
      # :hours=>"Mon, Tue, Thur, Fri  8:00 a.m.- 4:30 p.m. / Wed 8:30 a.m.-4:30 p.m.", :services_p=>"vehicle titles, registration, renewals; VIN inspections",
      # :parking_no=>"parking available in the lot at the back of the bldg (Glenarm Street)", :photo=>"images/Tremont.jpg", :address_id=>"175164", :":@computed_region_nku6_53ud"=>"1444"}
    end

    it 'contains expected values for the last facility_record element' do
      
      expect(@co_dmv_office_locations[-1][:dmv_office]).to eq("DMV Southeast Branch")
      expect(@co_dmv_office_locations[-1][:phone]).to eq("(720) 865-4600")
      expect(@co_dmv_office_locations[-1][:address_li]).to eq("2243 S Monaco Street Pkwy")
      expect(@co_dmv_office_locations[-1][:address__1]).to eq(nil)
      expect(@co_dmv_office_locations[-1][:city]).to eq("Denver")
      expect(@co_dmv_office_locations[-1][:state]).to eq("CO")
      expect(@co_dmv_office_locations[-1][:zip]).to eq("80222")
      
      #pry(main)> @co_dmv_office_locations[-1]
      #=> {:the_geom=>{:type=>"Point", :coordinates=>[-104.91476182907581, 39.67726719069066]}, :dmv_id=>"5", :dmv_office=>"DMV Southeast Branch",
      # :address_li=>"2243 S Monaco Street Pkwy", :location=>"Villa Monaco", :city=>"Denver", :state=>"CO", :zip=>"80222", :phone=>"(720) 865-4600",
      # :hours=>"Mon, Tue, Thur, Fri  8:00 a.m.- 4:30 p.m. / Wed 8:30 a.m.-4:30 p.m.", :services_p=>"vehicle titles, registration, renewals;  VIN inspections",
      # :parking_no=>"parking in front of the building", :photo=>"images/Monaco.jpg", :address_id=>"460381", :":@computed_region_nku6_53ud"=>"1444"}
    end

    it 'contains expected values for a middle facility_record element' do
      
      expect(@co_dmv_office_locations[2][:dmv_office]).to eq("DMV Northwest Branch")
      expect(@co_dmv_office_locations[2][:phone]).to eq("(720) 865-4600")
      expect(@co_dmv_office_locations[2][:address_li]).to eq("3698 W. 44th Avenue")
      expect(@co_dmv_office_locations[2][:address__1]).to eq(nil)
      expect(@co_dmv_office_locations[2][:city]).to eq("Denver")
      expect(@co_dmv_office_locations[2][:state]).to eq("CO")
      expect(@co_dmv_office_locations[2][:zip]).to eq("80211")
      
      #pry(main)> @co_dmv_office_locations[2]
      #=> {:the_geom=>{:type=>"Point", :coordinates=>[-105.03590369947995, 39.77608961495372]}, :dmv_id=>"3", :dmv_office=>"DMV Northwest Branch",
      # :address_li=>"3698 W. 44th Avenue", :location=>"Safeway Plaza", :city=>"Denver", :state=>"CO", :zip=>"80211", :phone=>"(720) 865-4600",
      # :hours=>"Mon, Tue, Thur, Fri  8:00 a.m.- 4:30 p.m. / Wed 8:30 a.m.-4:30 p.m.", :services_p=>"vehicle titles, registration, renewals;  VIN inspections",
      # :parking_no=>"parking in the lot in front of the building", :photo=>"images/44thAve.jpg", :address_id=>"29409", :":@computed_region_nku6_53ud"=>"1444"}
    end    
  end

  describe 'transformed Colorado Facility objects' do
  
    before(:each) do
      @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
      @colorado_facilities = @facility_factory.create_co_facilities(@co_dmv_office_locations)

      #for testing multiple elements at different index positions; this should avoid the first/last element and randomly pick one from the remaining elements
      #@random_middle_index = rand(1..@co_dmv_office_locations.length - 2)
      #pry(main)> @random_middle_index
      #=> 2
      @random_middle_index = 2
    end

    it 'creates CO facility objects correctly' do
      expect(@colorado_facilities).to be_an(Array)
      expect(@colorado_facilities[0]).to be_a(Facility)
    end

    it 'correctly transforms the first facility_record object' do
      raw_location_data = @co_dmv_office_locations[0]
      
      full_address = "#{raw_location_data[:address_li]} #{raw_location_data[:address__1]} #{raw_location_data[:city]} #{raw_location_data[:state]} #{raw_location_data[:zip]}"
      
      expect(@colorado_facilities[0].address).to eq(full_address)
      expect(@colorado_facilities[0].name).to eq("DMV Tremont Branch")
      expect(@colorado_facilities[0].phone).to eq("(720) 865-4600")
      
      #pry(main)> @colorado_facilities[0]
      #=> #<Facility:0x0000000105574760 @address="2855 Tremont Place Suite 118 Denver CO 80205", @collected_fees=0, @name="DMV Tremont Branch", @phone="(720) 865-4600", @registered_vehicles=[], @services=[]>
    end

    it 'correctly transforms the last facility_record object' do
      raw_location_data = @co_dmv_office_locations[-1]
      
      full_address = "#{raw_location_data[:address_li]} #{raw_location_data[:address__1]} #{raw_location_data[:city]} #{raw_location_data[:state]} #{raw_location_data[:zip]}"
      
      expect(@colorado_facilities[-1].address).to eq(full_address)
      expect(@colorado_facilities[-1].name).to eq("DMV Southeast Branch")
      expect(@colorado_facilities[-1].phone).to eq("(720) 865-4600")
      
      #pry(main)> @colorado_facilities[-1]
      #=> #<Facility:0x00000001055744e0 @address="2243 S Monaco Street Pkwy  Denver CO 80222", @collected_fees=0, @name="DMV Southeast Branch", @phone="(720) 865-4600", @registered_vehicles=[], @services=[]>
    end

    it 'correctly transforms a middle facility_record object' do
      raw_location_data = @co_dmv_office_locations[2]
      
      full_address = "#{raw_location_data[:address_li]} #{raw_location_data[:address__1]} #{raw_location_data[:city]} #{raw_location_data[:state]} #{raw_location_data[:zip]}"
      
      expect(@colorado_facilities[2].address).to eq(full_address)
      expect(@colorado_facilities[2].name).to eq("DMV Northwest Branch")
      expect(@colorado_facilities[2].phone).to eq("(720) 865-4600")
      
      #pry(main)> @colorado_facilities[2]
      #=> #<Facility:0x0000000105574620 @address="3698 W. 44th Avenue  Denver CO 80211", @collected_fees=0, @name="DMV Northwest Branch", @phone="(720) 865-4600", @registered_vehicles=[], @services=[]>
    end

  end

  describe 'raw New York DMV Office Locations data' do
    
    before(:each) do
      @ny_dmv_office_locations = DmvDataService.new.ny_dmv_office_locations
      
      #for testing multiple elements at different index positions; this should avoid the first/last element and randomly pick one from the remaining elements
      #@random_middle_index = rand(1..@ny_dmv_office_locations.length - 2)
      #pry(main)> @random_middle_index
      #=> 169
      @random_middle_index = 169
    end

    it 'is an array of facility hashes' do
      expect(@ny_dmv_office_locations).to be_an(Array)
      
      #@ny_dmv_office_locations is an array of hashes, where each hash represents an individual facility record
      #from the Colorado DMV Office Locations external data source
      
      #testing the return value for all of the keys used by any hash within the array of facility hashes to make sure I am accounting for multiple address lines or other differences that may exist between first element and others
      #pry(main)> @ny_dmv_office_locations.flat_map { |facility_record| facility_record.keys }.uniq
      # => [:office_name, :office_type, :street_address_line_1, :city, :state, :zip_code, :monday_beginning_hours, :monday_ending_hours,
      # :georeference, :":@computed_region_yamh_8v7k", :":@computed_region_wbg7_3whc", :":@computed_region_kjdx_g34t", :public_phone_number,
      # :tuesday_beginning_hours, :tuesday_ending_hours, :wednesday_beginning_hours, :wednesday_ending_hours, :thursday_beginning_hours, :thursday_ending_hours,
      # :friday_beginning_hours, :friday_ending_hours, :street_address_line_2, :public_phone_extension, :saturday_beginning_hours, :saturday_ending_hours]
    end
    
    it 'contains expected values for the first facility_record element' do
      
      expect(@ny_dmv_office_locations[0][:office_name]).to eq("LAKE PLACID")
      expect(@ny_dmv_office_locations[0][:phone]).to eq(nil)
      expect(@ny_dmv_office_locations[0][:street_address_line_1]).to eq("2693 MAIN STREET")
      expect(@ny_dmv_office_locations[0][:city]).to eq("LAKE PLACID")
      expect(@ny_dmv_office_locations[0][:state]).to eq("NY")
      expect(@ny_dmv_office_locations[0][:zip_code]).to eq("12946")
      
      #pry(main)> @ny_dmv_office_locations[0]
      #=> {:office_name=>"LAKE PLACID", :office_type=>"COUNTY OFFICE", :street_address_line_1=>"2693 MAIN STREET", :city=>"LAKE PLACID", :state=>"NY", :zip_code=>"12946",
      # :monday_beginning_hours=>"CLOSED", :monday_ending_hours=>"CLOSED", :georeference=>{:type=>"Point", :coordinates=>[-73.98278, 44.28213]}, :":@computed_region_yamh_8v7k"=>"430", 
      # :":@computed_region_wbg7_3whc"=>"275", :":@computed_region_kjdx_g34t"=>"2084"}
    end

    it 'contains expected values for the last facility_record element' do
      
      expect(@ny_dmv_office_locations[-1][:office_name]).to eq("MIDDLETOWN")
      expect(@ny_dmv_office_locations[-1][:phone]).to eq("8453461180")
      expect(@ny_dmv_office_locations[-1][:street_address_line_1]).to eq("12 KING STREET")
      expect(@ny_dmv_office_locations[-1][:city]).to eq("MIDDLETOWN")
      expect(@ny_dmv_office_locations[-1][:state]).to eq("NY")
      expect(@ny_dmv_office_locations[-1][:zip_code]).to eq("10940")
      
      #pry(main)> @ny_dmv_office_locations[-1]
      #=> {:office_name=>"MIDDLETOWN", :office_type=>"COUNTY OFFICE", :public_phone_number=>"8453461180", :street_address_line_1=>"12 KING STREET", :city=>"MIDDLETOWN", :state=>"NY", :zip_code=>"10940",
      # :monday_beginning_hours=>"9:00 AM", :monday_ending_hours=>"4:00 PM", :tuesday_beginning_hours=>"9:00 AM", :tuesday_ending_hours=>"4:00 PM", :wednesday_beginning_hours=>"9:00 AM",
      # :wednesday_ending_hours=>"7:00 PM", :thursday_beginning_hours=>"9:00 AM", :thursday_ending_hours=>"4:00 PM", :friday_beginning_hours=>"9:00 AM", :friday_ending_hours=>"4:00 PM",
      # :georeference=>{:type=>"Point", :coordinates=>[-74.42079, 41.4456]}, :":@computed_region_yamh_8v7k"=>"873", :":@computed_region_wbg7_3whc"=>"1540", :":@computed_region_kjdx_g34t"=>"2134"}
    end

    it 'contains expected values for a middle facility_record element' do
      
      expect(@ny_dmv_office_locations[169][:office_name]).to eq("NORTH SYRACUSE KIOSK")
      expect(@ny_dmv_office_locations[169][:phone]).to eq(nil)
      expect(@ny_dmv_office_locations[169][:street_address_line_1]).to eq("5801 E. TAFT ROAD")
      expect(@ny_dmv_office_locations[169][:city]).to eq("NORTH SYRACUSE")
      expect(@ny_dmv_office_locations[169][:state]).to eq("NY")
      expect(@ny_dmv_office_locations[169][:zip_code]).to eq("13212")
      
      #pry(main)> @ny_dmv_office_locations[169]
      #=> {:office_name=>"NORTH SYRACUSE KIOSK", :office_type=>"DISTRICT OFFICE", :street_address_line_1=>"5801 E. TAFT ROAD", :city=>"NORTH SYRACUSE", :state=>"NY", :zip_code=>"13212",
      # :monday_beginning_hours=>"7:30 AM", :monday_ending_hours=>"5:00 PM", :tuesday_beginning_hours=>"7:30 AM", :tuesday_ending_hours=>"5:00 PM", :wednesday_beginning_hours=>"7:30 AM",
      # :wednesday_ending_hours=>"5:00 PM", :thursday_beginning_hours=>"7:30 AM", :thursday_ending_hours=>"5:00 PM", :friday_beginning_hours=>"7:30 AM", :friday_ending_hours=>"5:00 PM",
      # :georeference=>{:type=>"Point", :coordinates=>[-76.1152, 43.12806]}, :":@computed_region_yamh_8v7k"=>"704", :":@computed_region_wbg7_3whc"=>"730", :":@computed_region_kjdx_g34t"=>"2132"}
    end    
  end

  describe 'transformed New York Facility objects' do
  
    before(:each) do
      @ny_dmv_office_locations = DmvDataService.new.ny_dmv_office_locations
      @new_york_facilities = @facility_factory.create_ny_facilities(@ny_dmv_office_locations)

      #for testing multiple elements at different index positions; this should avoid the first/last element and randomly pick one from the remaining elements
      @random_middle_index = rand(1..@ny_dmv_office_locations.length - 2)
      #pry(main)> @random_middle_index
      #=> 169
      @random_middle_index = 169
    end

    it 'creates CO facility objects correctly' do
      expect(@new_york_facilities).to be_an(Array)
      expect(@new_york_facilities[0]).to be_a(Facility)
    end

    it 'correctly transforms the first facility_record object' do
      raw_location_data = @ny_dmv_office_locations[0]
      
      full_address = "#{raw_location_data[:street_address_line_1]} #{raw_location_data[:city]} #{raw_location_data[:state]} #{raw_location_data[:zip_code]}"
      
      expect(@new_york_facilities[0].address).to eq(full_address)
      expect(@new_york_facilities[0].name).to eq("LAKE PLACID")
      expect(@new_york_facilities[0].phone).to eq(nil)
      
      #pry(main)> @new_york_facilities[0]
      #=> #<Facility:0x0000000103788a30 @address="2693 MAIN STREET LAKE PLACID NY 12946", @collected_fees=0, @name="LAKE PLACID", @phone=nil, @registered_vehicles=[], @services=[]>
    end

    it 'correctly transforms the last facility_record object' do
      raw_location_data = @ny_dmv_office_locations[-1]
      
      full_address = "#{raw_location_data[:street_address_line_1]} #{raw_location_data[:city]} #{raw_location_data[:state]} #{raw_location_data[:zip_code]}"

      expect(@new_york_facilities[-1].address).to eq(full_address)
      expect(@new_york_facilities[-1].name).to eq("MIDDLETOWN")
      expect(@new_york_facilities[-1].phone).to eq("8453461180")
      
      #pry(main)> @new_york_facilities[-1]
      #=> #<Facility:0x00000001037813c0 @address="12 KING STREET MIDDLETOWN NY 10940", @collected_fees=0, @name="MIDDLETOWN", @phone="8453461180", @registered_vehicles=[], @services=[]>
    end

    it 'correctly transforms a middle facility_record object' do
      raw_location_data = @ny_dmv_office_locations[169]
      
      full_address = "#{raw_location_data[:street_address_line_1]} #{raw_location_data[:city]} #{raw_location_data[:state]} #{raw_location_data[:zip_code]}"

      expect(@new_york_facilities[169].address).to eq(full_address)
      expect(@new_york_facilities[169].name).to eq("NORTH SYRACUSE KIOSK")
      expect(@new_york_facilities[169].phone).to eq(nil)
      
      #pry(main)> @new_york_facilities[169]
      #=> #<Facility:0x00000001037815a0 @address="5801 E. TAFT ROAD NORTH SYRACUSE NY 13212", @collected_fees=0, @name="NORTH SYRACUSE KIOSK", @phone=nil, @registered_vehicles=[], @services=[]>
    end

  end

  # describe 'New York facility data' do
    
  #   before(:each) do
  #     @ny_dmv_office_locations = DmvDataService.new.ny_dmv_office_locations
      
  #     #testing return value for the first element in the @ny_dmv_office_locations array to make sure it works
  #     #pry(main)> @ny_dmv_office_locations[0]
  #     #=> {:office_name=>"LAKE PLACID", :office_type=>"COUNTY OFFICE", :street_address_line_1=>"2693 MAIN STREET", :city=>"LAKE PLACID", :state=>"NY", :zip_code=>"12946",
  #     # :monday_beginning_hours=>"CLOSED", :monday_ending_hours=>"CLOSED", :georeference=>{:type=>"Point", :coordinates=>[-73.98278, 44.28213]}, :":@computed_region_yamh_8v7k"=>"430", 
  #     # :":@computed_region_wbg7_3whc"=>"275", :":@computed_region_kjdx_g34t"=>"2084"}

  #     @new_york_facilities = @facility_factory.create_ny_facilities(@ny_dmv_office_locations)
  #   end

  #   it 'creates NY facility objects correctly' do
  #     expect(@new_york_facilities).to be_an(Array)
  #     expect(@new_york_facilities[0]).to be_a(Facility)
  
  #     #testing the return value for all of the keys within the hash of the first facility record element in the @ny_dmv_office_locations array to make sure the mapping logic is using the correct keys
  #     #pry(main)> @ny_dmv_office_locations[0].keys
  #     #=> [:office_name, :office_type, :street_address_line_1, :city, :state, :zip_code, :monday_beginning_hours, :monday_ending_hours,
  #     # :georeference, :":@computed_region_yamh_8v7k", :":@computed_region_wbg7_3whc", :":@computed_region_kjdx_g34t"]

  #     #testing the return value for all of the keys used by any hash within the array of facility hashes to make sure I am accounting for multiple address lines or other differences that may exist between first element and others
  #     #pry(main)> @ny_dmv_office_locations.flat_map { |facility_record| facility_record.keys }.uniq
  #     # => [:office_name, :office_type, :street_address_line_1, :city, :state, :zip_code, :monday_beginning_hours, :monday_ending_hours,
  #     # :georeference, :":@computed_region_yamh_8v7k", :":@computed_region_wbg7_3whc", :":@computed_region_kjdx_g34t", :public_phone_number,
  #     # :tuesday_beginning_hours, :tuesday_ending_hours, :wednesday_beginning_hours, :wednesday_ending_hours, :thursday_beginning_hours, :thursday_ending_hours,
  #     # :friday_beginning_hours, :friday_ending_hours, :street_address_line_2, :public_phone_extension, :saturday_beginning_hours, :saturday_ending_hours]
  #   end

  #   it 'correctly transforms the first facility_record object' do
  #     raw_location_data = @ny_dmv_office_locations[0]
     
  #     full_address = "#{raw_location_data[:street_address_line_1]} #{raw_location_data[:city]} #{raw_location_data[:state]} #{raw_location_data[:zip_code]}"
      
  #     expect(@new_york_facilities[0].address).to eq(full_address)
  #     expect(@new_york_facilities[0].name).to eq("LAKE PLACID")
  #     expect(@new_york_facilities[0].phone).to eq(nil)

  #     #pry(main)> @new_york_facilities[0]
  #     #=> <Facility:0x0000000103c8f970 @name="LAKE PLACID", @address="2693 MAIN STREET  LAKE PLACID NY 12946", @phone="(417) 548-7332", @services=[], @registered_vehicles=[], @collected_fees=0>
  #   end
  # end

  # describe 'Missouri facility data' do
    
  #   before(:each) do
  #     @mo_dmv_office_locations = DmvDataService.new.mo_dmv_office_locations
      
  #     #testing return value for the first element in the @mo_dmv_office_locations array to make sure it works
  #     #pry(main)> @mo_dmv_office_locations[0]
  #     #=> {:number=>"032", :type=>"1MV", :name=>"Sarcoxie", :address1=>"111 N 6th", :city=>"Sarcoxie", :state=>"MO", :zipcode=>"64862", :phone=>"(417) 548-7332", :fax=>"(417) 548-3108",
  #     # :size=>"2", :email=>"sarcoxie.licenseoffice@lo.mo.gov", :agent=>"City of Sarcoxie", :officemanager=>"Heather Swan", :contractmanager=>"Don Triplett",
  #     # :daysopen=>"Monday & Friday 8:30-5:00, Tuesday - Thursday 8:30-4:30", :daysclosed=>"Monday & Friday 1:00-1:30",
  #     # :holidaysclosed=> "New Year's (1/1/2025), Martin Luther King Jr. Day (1/20/2025), Washington's Birthday (2/17/2025), Memorial Day (5/26/2025), Independence Day (7/4/2025), Labor Day (9/1/2025), Veteran's Day (11/11/2025), Thanksgiving Day (11/27/2025), Christmas Day (12/25/2025)",
  #     # :additionaldaysclosed=>"4/18/2025, 1/10/2025, 2/18/2025, 2/19/2025, 3/17/2025", :latlng=>{:latitude=>"37.0686822", :longitude=>"-94.1163988"},
  #     # :":@computed_region_ny2h_ckbz"=>"410", :":@computed_region_c8ar_jsdj"=>"94", :":@computed_region_ikxf_gfzr"=>"1966"}

  #     @missouri_facilities = @facility_factory.create_mo_facilities(@mo_dmv_office_locations)
  #   end

  #   it 'creates MO facility objects correctly' do
  #     expect(@missouri_facilities).to be_an(Array)
  #     expect(@missouri_facilities[0]).to be_a(Facility)

  #     #testing the return value for all of the keys within the hash of the first facility record element in the @mo_dmv_office_locations array to make sure the mapping logic is using the correct keys
  #     #pry(main)> @mo_dmv_office_locations[0].keys
  #     #=> [:number, :type, :name, :address1, :city, :state, :zipcode, :phone, :fax, :size, :email, :agent, :officemanager, :contractmanager,
  #     # :daysopen, :daysclosed, :holidaysclosed, :additionaldaysclosed, :latlng, :":@computed_region_ny2h_ckbz", :":@computed_region_c8ar_jsdj", :":@computed_region_ikxf_gfzr"]

  #     #testing the return value for all of the keys used by any hash within the array of facility hashes to make sure I am accounting for multiple address lines or other differences that may exist between first element and others
  #     #pry(main)> @mo_dmv_office_locations.flat_map { |facility_record| facility_record.keys }.uniq
  #     #=> [:number, :type, :name, :address1, :city, :state, :zipcode, :phone, :fax, :size, :email, :agent, :officemanager, :contractmanager, :daysopen, :daysclosed, :holidaysclosed, :additionaldaysclosed,
  #     # :latlng, :":@computed_region_ny2h_ckbz", :":@computed_region_c8ar_jsdj", :":@computed_region_ikxf_gfzr", :facebook_url, :managercontactnumber, :othercontactinfo, :dorregionnumber, :remarks, :additional_license_office_info]
  #   end

  #   it 'correctly transforms the first facility_record object' do
  #     raw_location_data = @mo_dmv_office_locations[0]
      
  #     full_address = "#{raw_location_data[:address1]} #{raw_location_data[:city]} #{raw_location_data[:state]} #{raw_location_data[:zipcode]}"
      
  #     expect(@missouri_facilities[0].address).to eq(full_address)
  #     expect(@missouri_facilities[0].name).to eq("Sarcoxie")
  #     expect(@missouri_facilities[0].phone).to eq("(417) 548-7332")
      
  #     #pry(main)> @missouri_facilities[0]
  #     #=> #<Facility:0x00000001042a8bb8 @name="Sarcoxie", @address="111 N 6th  Sarcoxie MO 64862", @phone="(417) 548-7332", @services=[], @registered_vehicles=[], @collected_fees=0>

  #   end
  # end


end