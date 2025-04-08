require 'spec_helper'

RSpec.describe FacilityFactory do
  
  before(:each) do
    @facility_factory = FacilityFactory.new
  end

  it 'exists' do
      expect(@facility_factory).to be_an_instance_of(FacilityFactory)
  end
  
  #testing specific to the new dynamic method I made to support multiple state datasets via the new location parameter
  describe '#create_facilities (dynamic multi-state support)' do
      
    describe 'for Colorado locations' do
        
      before(:each) do
          @co_data = DmvDataService.new.co_dmv_office_locations
          @colorado_facilities = @facility_factory.create_facilities("Colorado", @co_data)
      end

      it 'creates a Facility object for DMV Tremont Branch' do
        
        #partial string matches using the .find method on the arrays of hashes for the raw and transformed data
        raw_location_data = @co_data.find { |record| record[:dmv_office] == "DMV Tremont Branch" }
        facility_record = @colorado_facilities.find { |facility| facility.name == "DMV Tremont Branch" }

        #additional tests for dynamically positioned elements based on new logic
        expect(facility_record).to be_a(Facility)
        expect(facility_record.name).to eq(raw_location_data[:dmv_office])
        expect(facility_record.phone).to eq(raw_location_data[:phone])
        expect(facility_record.address).to include(raw_location_data[:city])

        #puts @colorado_facilities
        #=> #<Facility:0x0000000105574760 @address="2855 Tremont Place Suite 118 Denver CO 80205", @collected_fees=0, @name="DMV Tremont Branch", @phone="(720) 865-4600", @registered_vehicles=[], @services=[]>
      end

      it 'creates a Facility object for DMV Southeast Branch' do
        raw_location_data = @co_data.find { |record| record[:dmv_office] == "DMV Southeast Branch" }
        facility_record = @colorado_facilities.find { |facility| facility.name == "DMV Southeast Branch" }

        expect(facility_record).to be_a(Facility)
        expect(facility_record.name).to eq(raw_location_data[:dmv_office])
        expect(facility_record.phone).to eq(raw_location_data[:phone])
        expect(facility_record.address).to include(raw_location_data[:city])

        #puts @colorado_facilities
        #=> #<Facility:0x00000001055744e0 @address="2243 S Monaco Street Pkwy  Denver CO 80222", @collected_fees=0, @name="DMV Southeast Branch", @phone="(720) 865-4600", @registered_vehicles=[], @services=[]>

      end

      it 'creates a Facility object for DMV Northwest Branch' do
        raw_location_data = @co_data.find { |record| record[:dmv_office] == "DMV Northwest Branch" }
        facility_record = @colorado_facilities.find { |facility| facility.name == "DMV Northwest Branch" }

        expect(facility_record).to be_a(Facility)
        expect(facility_record.name).to eq(raw_location_data[:dmv_office])
        expect(facility_record.phone).to eq(raw_location_data[:phone])
        expect(facility_record.address).to include(raw_location_data[:city])

        #puts @colorado_facilities
        #=> #<Facility:0x0000000105574620 @address="3698 W. 44th Avenue  Denver CO 80211", @collected_fees=0, @name="DMV Northwest Branch", @phone="(720) 865-4600", @registered_vehicles=[], @services=[]>
        
      end
    
    end

    describe 'for New York locations' do
      
      before(:each) do
        @ny_data = DmvDataService.new.ny_dmv_office_locations
        @new_york_facilities = @facility_factory.create_facilities("New York", @ny_data)
      end

      it 'creates a Facility object for LAKE PLACID' do
        raw_location_data = @ny_data.find { |record| record[:office_name] == "LAKE PLACID" }
        facility_record = @new_york_facilities.find { |facility| facility.name == "LAKE PLACID" }

        expect(facility_record).to be_a(Facility)
        expect(facility_record.name).to eq(raw_location_data[:office_name])
        expect(facility_record.phone).to eq(raw_location_data[:public_phone_number])
        expect(facility_record.address).to include(raw_location_data[:city])

        # puts @new_york_facilities
        #=> #<Facility:0x0000000103788a30 @address="2693 MAIN STREET LAKE PLACID NY 12946", @collected_fees=0, @name="LAKE PLACID", @phone=nil, @registered_vehicles=[], @services=[]>
      end

      it 'creates a Facility object for MIDDLETOWN' do
        raw_location_data = @ny_data.find { |record| record[:office_name] == "MIDDLETOWN" }
        facility_record = @new_york_facilities.find { |facility| facility.name == "MIDDLETOWN" }

        expect(facility_record).to be_a(Facility)
        expect(facility_record.name).to eq(raw_location_data[:office_name])
        expect(facility_record.phone).to eq(raw_location_data[:public_phone_number])
        expect(facility_record.address).to include(raw_location_data[:city])

        # puts @new_york_facilities
        #=> #<Facility:0x00000001037813c0 @address="12 KING STREET MIDDLETOWN NY 10940", @collected_fees=0, @name="MIDDLETOWN", @phone="8453461180", @registered_vehicles=[], @services=[]>
      end

      it 'creates a Facility object for NORTH SYRACUSE KIOSK' do
        raw_location_data = @ny_data.find { |record| record[:office_name] == "NORTH SYRACUSE KIOSK" }
        facility_record = @new_york_facilities.find { |facility| facility.name == "NORTH SYRACUSE KIOSK" }

        expect(facility_record).to be_a(Facility)
        expect(facility_record.name).to eq(raw_location_data[:office_name])
        expect(facility_record.phone).to eq(raw_location_data[:public_phone_number])
        expect(facility_record.address).to include(raw_location_data[:city])

        # puts @new_york_facilities
        #=> #<Facility:0x00000001037815a0 @address="5801 E. TAFT ROAD NORTH SYRACUSE NY 13212", @collected_fees=0, @name="NORTH SYRACUSE KIOSK", @phone=nil, @registered_vehicles=[], @services=[]>
      end
    
    end

    describe 'for Missouri locations' do
      
      before(:each) do
        @mo_data = DmvDataService.new.mo_dmv_office_locations
        @missouri_facilities = @facility_factory.create_facilities("Missouri", @mo_data)
      end
    
      it 'creates a Facility object for Cameron' do
        raw_location_data = @mo_data.find { |record| record[:name] == "Cameron" }
        facility_record = @missouri_facilities.find { |facility| facility.name == "Cameron" }
    
        expect(facility_record).to be_a(Facility)
        expect(facility_record.name).to eq(raw_location_data[:name])
        expect(facility_record.phone).to eq(raw_location_data[:phone])
        expect(facility_record.address).to include(raw_location_data[:city])
    
        #puts @missouri_facilities
        #=> #<Facility:0x00000001048f4990 @address="508 Lana DR Cameron MO 64429", @collected_fees=0, @name="Cameron", @phone="(816) 632-4830", @registered_vehicles=[], @services=[]>
      end
    
      it 'creates a Facility object for Steelville' do
        raw_location_data = @mo_data.find { |record| record[:name] == "Steelville" }
        facility_record = @missouri_facilities.find { |facility| facility.name == "Steelville" }
    
        expect(facility_record).to be_a(Facility)
        expect(facility_record.name).to eq(raw_location_data[:name])
        expect(facility_record.phone).to eq(raw_location_data[:phone])
        expect(facility_record.address).to include(raw_location_data[:city])
    
        #puts @missouri_facilities
        #=> #<Facility:0x00000001047f89d8 @address="207 W Main ST Steelville MO 65565", @collected_fees=0, @name="Steelville", @phone="(573) 775-3828", @registered_vehicles=[], @services=[]>
      end
    
      it 'creates a Facility object for Alton' do
        raw_location_data = @mo_data.find { |record| record[:name] == "Alton" }
        facility_record = @missouri_facilities.find { |facility| facility.name == "Alton" }
    
        expect(facility_record).to be_a(Facility)
        expect(facility_record.name).to eq(raw_location_data[:name])
        expect(facility_record.phone).to eq(raw_location_data[:phone])
        expect(facility_record.address).to include(raw_location_data[:city])
    
        #puts @missouri_facilities
        #=> #<Facility:0x00000001047ff0a8 @address="#26 Court Square Alton MO 65606", @collected_fees=0, @name="Alton", @phone="(417) 778-2004", @registered_vehicles=[], @services=[]>
      end
    
    end
  
  end

  #testing state-specific raw and transformed data separately from dynamic method above
  describe 'raw Colorado DMV Office Locations data' do
    
    before(:each) do
      @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
    end

    it 'is an array of facility hashes' do
      expect(@co_dmv_office_locations).to be_an(Array)
      
      #@co_dmv_office_locations is an array of hashes, where each hash represents an individual facility record
      #from the Colorado DMV Office Locations external data source
      
      #testing the return value for all of the keys used by any hash within the array of facility hashes to make sure I am accounting for multiple address lines or other differences that may exist between first element and others
      #pry(main)> @co_dmv_office_locations.flat_map { |facility_record| facility_record.keys }.uniq
      #=> [:the_geom, :dmv_id, :dmv_office, :address_li, :address__1, :city, :state, :zip, :phone, :hours, :services_p, :parking_no, :photo, :address_id, :":@computed_region_nku6_53ud", :location]
    end
    
    it 'contains expected values for a facility_record with name DMV Tremont Branch' do
      raw_location_data = @co_dmv_office_locations.find { |facility| facility[:dmv_office] == "DMV Tremont Branch" }
    
      expect(raw_location_data[:phone]).to eq("(720) 865-4600")
      expect(raw_location_data[:address_li]).to eq("2855 Tremont Place")
      expect(raw_location_data[:city]).to eq("Denver")
      expect(raw_location_data[:state]).to eq("CO")
      expect(raw_location_data[:zip]).to eq("80205")

      #additional dynamic logic to allow me to find the locations in the first place to know what the expected return values should be
      #based on the static examples I found from index position initially

      # inspect_raw_location_data_1 = @co_dmv_office_locations.find { |facility| facility[:dmv_office] == "DMV Tremont Branch" }
      # puts inspect_raw_location_data_1
      #=> {:the_geom=>{:type=>"Point", :coordinates=>[-104.97443112500002, 39.75525297420336]}, :dmv_id=>"1", :dmv_office=>"DMV Tremont Branch",
      # :address_li=>"2855 Tremont Place", :address__1=>"Suite 118", :city=>"Denver", :state=>"CO", :zip=>"80205", :phone=>"(720) 865-4600",
      # :hours=>"Mon, Tue, Thur, Fri  8:00 a.m.- 4:30 p.m. / Wed 8:30 a.m.-4:30 p.m.", :services_p=>"vehicle titles, registration, renewals; VIN inspections",
      # :parking_no=>"parking available in the lot at the back of the bldg (Glenarm Street)", :photo=>"images/Tremont.jpg", :address_id=>"175164", :":@computed_region_nku6_53ud"=>"1444"}
    end
        
    it 'contains expected values for a facility_record with name DMV Southeast Branch' do
      raw_location_data = @co_dmv_office_locations.find { |facility| facility[:dmv_office] == "DMV Southeast Branch" }

      expect(raw_location_data[:phone]).to eq("(720) 865-4600")
      expect(raw_location_data[:address_li]).to eq("2243 S Monaco Street Pkwy")
      expect(raw_location_data[:address__1]).to eq(nil)
      expect(raw_location_data[:city]).to eq("Denver")
      expect(raw_location_data[:state]).to eq("CO")
      expect(raw_location_data[:zip]).to eq("80222")

      # inspect_raw_location_data_2 = @co_dmv_office_locations.find { |facility| facility[:dmv_office] == "DMV Southeast Branch" }
      # puts inspect_raw_location_data_2
      #=> {:the_geom=>{:type=>"Point", :coordinates=>[-104.91476182907581, 39.67726719069066]}, :dmv_id=>"5", :dmv_office=>"DMV Southeast Branch",
      # :address_li=>"2243 S Monaco Street Pkwy", :location=>"Villa Monaco", :city=>"Denver", :state=>"CO", :zip=>"80222", :phone=>"(720) 865-4600",
      # :hours=>"Mon, Tue, Thur, Fri  8:00 a.m.- 4:30 p.m. / Wed 8:30 a.m.-4:30 p.m.", :services_p=>"vehicle titles, registration, renewals;  VIN inspections",
      # :parking_no=>"parking in front of the building", :photo=>"images/Monaco.jpg", :address_id=>"460381", :":@computed_region_nku6_53ud"=>"1444"}
    end

    it 'contains expected values for a facility_record with name DMV Northwest Branch' do
      raw_location_data = @co_dmv_office_locations.find { |facility| facility[:dmv_office] == "DMV Northwest Branch" }

      expect(raw_location_data[:phone]).to eq("(720) 865-4600")
      expect(raw_location_data[:address_li]).to eq("3698 W. 44th Avenue")
      expect(raw_location_data[:address__1]).to eq(nil)
      expect(raw_location_data[:city]).to eq("Denver")
      expect(raw_location_data[:state]).to eq("CO")
      expect(raw_location_data[:zip]).to eq("80211")
      
      # inspect_raw_location_data_3 = @co_dmv_office_locations.find { |facility| facility[:dmv_office] == "DMV Northwest Branch" }
      # puts inspect_raw_location_data_3
      #=> {:the_geom=>{:type=>"Point", :coordinates=>[-105.03590369947995, 39.77608961495372]}, :dmv_id=>"3", :dmv_office=>"DMV Northwest Branch",
      # :address_li=>"3698 W. 44th Avenue", :location=>"Safeway Plaza", :city=>"Denver", :state=>"CO", :zip=>"80211", :phone=>"(720) 865-4600",
      # :hours=>"Mon, Tue, Thur, Fri  8:00 a.m.- 4:30 p.m. / Wed 8:30 a.m.-4:30 p.m.", :services_p=>"vehicle titles, registration, renewals;  VIN inspections",
      # :parking_no=>"parking in the lot in front of the building", :photo=>"images/44thAve.jpg", :address_id=>"29409", :":@computed_region_nku6_53ud"=>"1444"}
    end    
  
  end

  describe 'raw New York DMV Office Locations data' do

    before(:each) do
      @ny_dmv_office_locations = DmvDataService.new.ny_dmv_office_locations
    end
  
    it 'is an array of facility hashes' do
      expect(@ny_dmv_office_locations).to be_an(Array)
      
      #@ny_dmv_office_locations is an array of hashes, where each hash represents an individual facility record
      #from the New York DMV Office Locations external data source
      
      #testing the return value for all of the keys used by any hash within the array of facility hashes to make sure I am accounting for multiple address lines or other differences that may exist between first element and others
      #pry(main)> @ny_dmv_office_locations.flat_map { |facility_record| facility_record.keys }.uniq
      # => [:office_name, :office_type, :street_address_line_1, :city, :state, :zip_code, :monday_beginning_hours, :monday_ending_hours,
      # :georeference, :":@computed_region_yamh_8v7k", :":@computed_region_wbg7_3whc", :":@computed_region_kjdx_g34t", :public_phone_number,
      # :tuesday_beginning_hours, :tuesday_ending_hours, :wednesday_beginning_hours, :wednesday_ending_hours, :thursday_beginning_hours, :thursday_ending_hours,
      # :friday_beginning_hours, :friday_ending_hours, :street_address_line_2, :public_phone_extension, :saturday_beginning_hours, :saturday_ending_hours]
    end
  
    it 'contains expected values for a facility_record with name LAKE PLACID' do
      raw_location_data = @ny_dmv_office_locations.find { |facility| facility[:office_name] == "LAKE PLACID" }
  
      expect(raw_location_data[:public_phone_number]).to eq(nil)
      expect(raw_location_data[:street_address_line_1]).to eq("2693 MAIN STREET")
      expect(raw_location_data[:city]).to eq("LAKE PLACID")
      expect(raw_location_data[:state]).to eq("NY")
      expect(raw_location_data[:zip_code]).to eq("12946")

      # inspect_raw_location_data_1 = @ny_dmv_office_locations.find { |facility| facility[:dmv_office] == "LAKE PLACID" }
      # puts inspect_raw_location_data_1
      #=> {:office_name=>"LAKE PLACID", :office_type=>"COUNTY OFFICE", :street_address_line_1=>"2693 MAIN STREET", :city=>"LAKE PLACID", :state=>"NY", :zip_code=>"12946",
      # :monday_beginning_hours=>"CLOSED", :monday_ending_hours=>"CLOSED", :georeference=>{:type=>"Point", :coordinates=>[-73.98278, 44.28213]}, :":@computed_region_yamh_8v7k"=>"430", 
      # :":@computed_region_wbg7_3whc"=>"275", :":@computed_region_kjdx_g34t"=>"2084"}
    end
  
    it 'contains expected values for a facility_record with name MIDDLETOWN' do
      raw_location_data = @ny_dmv_office_locations.find { |facility| facility[:office_name] == "MIDDLETOWN" }
  
      expect(raw_location_data[:public_phone_number]).to eq("8453461180")
      expect(raw_location_data[:street_address_line_1]).to eq("12 KING STREET")
      expect(raw_location_data[:city]).to eq("MIDDLETOWN")
      expect(raw_location_data[:state]).to eq("NY")
      expect(raw_location_data[:zip_code]).to eq("10940")

      # inspect_raw_location_data_2 = @ny_dmv_office_locations.find { |facility| facility[:dmv_office] == "MIDDLETOWN" }
      # puts inspect_raw_location_data_2
      #=> {:office_name=>"MIDDLETOWN", :office_type=>"COUNTY OFFICE", :public_phone_number=>"8453461180", :street_address_line_1=>"12 KING STREET", :city=>"MIDDLETOWN", :state=>"NY", :zip_code=>"10940",
      # :monday_beginning_hours=>"9:00 AM", :monday_ending_hours=>"4:00 PM", :tuesday_beginning_hours=>"9:00 AM", :tuesday_ending_hours=>"4:00 PM", :wednesday_beginning_hours=>"9:00 AM",
      # :wednesday_ending_hours=>"7:00 PM", :thursday_beginning_hours=>"9:00 AM", :thursday_ending_hours=>"4:00 PM", :friday_beginning_hours=>"9:00 AM", :friday_ending_hours=>"4:00 PM",
      # :georeference=>{:type=>"Point", :coordinates=>[-74.42079, 41.4456]}, :":@computed_region_yamh_8v7k"=>"873", :":@computed_region_wbg7_3whc"=>"1540", :":@computed_region_kjdx_g34t"=>"2134"}
    end
  
    it 'contains expected values for a facility_record with name NORTH SYRACUSE KIOSK' do
      raw_location_data = @ny_dmv_office_locations.find { |facility| facility[:office_name] == "NORTH SYRACUSE KIOSK" }
  
      expect(raw_location_data[:public_phone_number]).to eq(nil)
      expect(raw_location_data[:street_address_line_1]).to eq("5801 E. TAFT ROAD")
      expect(raw_location_data[:city]).to eq("NORTH SYRACUSE")
      expect(raw_location_data[:state]).to eq("NY")
      expect(raw_location_data[:zip_code]).to eq("13212")

      # inspect_raw_location_data_3 = @ny_dmv_office_locations.find { |facility| facility[:dmv_office] == "NORTH SYRACUSE KIOSK" }
      # puts inspect_raw_location_data_3
      #=> {:office_name=>"NORTH SYRACUSE KIOSK", :office_type=>"DISTRICT OFFICE", :street_address_line_1=>"5801 E. TAFT ROAD", :city=>"NORTH SYRACUSE", :state=>"NY", :zip_code=>"13212",
      # :monday_beginning_hours=>"7:30 AM", :monday_ending_hours=>"5:00 PM", :tuesday_beginning_hours=>"7:30 AM", :tuesday_ending_hours=>"5:00 PM", :wednesday_beginning_hours=>"7:30 AM",
      # :wednesday_ending_hours=>"5:00 PM", :thursday_beginning_hours=>"7:30 AM", :thursday_ending_hours=>"5:00 PM", :friday_beginning_hours=>"7:30 AM", :friday_ending_hours=>"5:00 PM",
      # :georeference=>{:type=>"Point", :coordinates=>[-76.1152, 43.12806]}, :":@computed_region_yamh_8v7k"=>"704", :":@computed_region_wbg7_3whc"=>"730", :":@computed_region_kjdx_g34t"=>"2132"}
    end
  
  end
  
  describe 'raw Missouri DMV Office Locations data' do
    
    before(:each) do
      @mo_dmv_office_locations = DmvDataService.new.mo_dmv_office_locations
    end
  
    it 'is an array of facility hashes' do
      expect(@mo_dmv_office_locations).to be_an(Array)
      
      #@mo_dmv_office_locations is an array of hashes, where each hash represents an individual facility record
      #from the Missouri DMV Office Locations external data source
      
      #testing the return value for all of the keys used by any hash within the array of facility hashes to make sure I am accounting for multiple address lines or other differences that may exist between first element and others
      #pry(main)> @mo_dmv_office_locations.flat_map { |facility_record| facility_record.keys }.uniq
      #=> [:number, :type, :name, :address1, :city, :state, :zipcode, :phone, :fax, :size, :email, :agent, :officemanager, :contractmanager, :daysopen, :daysclosed, :holidaysclosed, :additionaldaysclosed,
      # :latlng, :":@computed_region_ny2h_ckbz", :":@computed_region_c8ar_jsdj", :":@computed_region_ikxf_gfzr", :facebook_url, :managercontactnumber, :othercontactinfo, :dorregionnumber, :remarks, :additional_license_office_info]
    end
  
    it 'contains expected values for a facility_record with name Cameron' do
      raw_location_data = @mo_dmv_office_locations.find { |facility| facility[:name] == "Cameron" }
  
      expect(raw_location_data[:phone]).to eq("(816) 632-4830")
      expect(raw_location_data[:address1]).to eq("508 Lana DR")
      expect(raw_location_data[:city]).to eq("Cameron")
      expect(raw_location_data[:state]).to eq("MO")
      expect(raw_location_data[:zipcode]).to eq("64429")

      # inspect_raw_location_data_1 = @mo_dmv_office_locations.find { |facility| facility[:dmv_office] == "Cameron" }
      # puts inspect_raw_location_data_1
      #=> {:number=>"119", :type=>"1MV", :name=>"Cameron", :address1=>"508 Lana DR", :city=>"Cameron", :state=>"MO", :zipcode=>"64429", :phone=>"(816) 632-4830", :fax=>"(816) 632-4831",
      # :size=>"2", :email=>"cameron.licenseoffice@lo.mo.gov", :agent=>"Rebecca A. Curtis DBA Cameron License Office", :officemanager=>"Rebecca A. Curtis", :contractmanager=>"Rebecca A. Curtis",
      # :daysopen=>"LAST SATURDAY OF THE MONTH 9:00-12:00, Monday - Friday 8:30-5:00",
      # :holidaysclosed=> "Thanksgiving (11/28/2024), Christmas (12/25/2024), New Year's Day (1/1/2025), President's Day (2/17/2025), Memorial Day (5/26/2025), Juneteenth (6/19/2025), Independence Day (7/04/2025), Labor Day (9/1/2025), Veteran's Day (11/11/2025), Thanksgiving (11/27/2025), Christmas (12/25/2025)",
      # :additionaldaysclosed=>"12/26/2024, 8/30/2025, 11/28/2025, 11/29/2025, 12/26/2025, 12/27/2025, 1/6/2025, 2/18/2025, 3/14/2025", :latlng=>{:latitude=>"39.752195", :longitude=>"-94.233915"},
      # :":@computed_region_ny2h_ckbz"=>"67", :":@computed_region_c8ar_jsdj"=>"19", :":@computed_region_ikxf_gfzr"=>"519"}
    end
  
    it 'contains expected values for a facility_record with name Steelville' do
      raw_location_data = @mo_dmv_office_locations.find { |facility| facility[:name] == "Steelville" }
  
      expect(raw_location_data[:phone]).to eq("(573) 775-3828")
      expect(raw_location_data[:address1]).to eq("207 W Main ST")
      expect(raw_location_data[:city]).to eq("Steelville")
      expect(raw_location_data[:state]).to eq("MO")
      expect(raw_location_data[:zipcode]).to eq("65565")

      # inspect_raw_location_data_2 = @mo_dmv_office_locations.find { |facility| facility[:dmv_office] == "Steelville" }
      # puts inspect_raw_location_data_2
      #=> {:number=>"107", :type=>"1MV", :name=>"Steelville", :address1=>"207 W Main ST", :city=>"Steelville", :state=>"MO", :zipcode=>"65565", :phone=>"(573) 775-3828", :fax=>"(573) 775-2838",
      # :size=>"2", :email=>"steelville.licenseoffice@lo.mo.gov", :agent=>"Steelville License Office", :officemanager=>"Ashley Beasley", :contractmanager=>"Cynthia Crawford",
      # :daysopen=>"Monday - Friday 9:00-5:00", :daysclosed=>"Monday - Friday 12:30-1:30",
      # :holidaysclosed=> "Thanksgiving (11/28/2024), Christmas (12/25/2024), New Year's Day (1/1/2025), Martin Luther King Jr. Day (1/20/2025), Lincoln's Birthday (2/12/2025), President's Day (2/17/2025), Truman's Birthday (5/8/2025), Memorial Day (5/26/2025), Juneteenth (6/19/2025), Independence Day (7/04/2025), Labor Day (9/1/2025), Columbus Day (10/13/2025), Veteran's Day (11/11/2025), Thanksgiving (11/27/2025), Christmas (12/25/2025)",
      # :additionaldaysclosed=>  "11/29/2024, 12/26/2024, 12/27/2024, 4/18/2025, 9/12/2025, 11/28/2025, 12/26/2025, 11/22/2024, 1/6/2025, 1/7/2025, 1/10/2025, 2/18/2025, 2/19/2025", :latlng=>{:latitude=>"37.9680699", :longitude=>"-91.3552082"},
      # :":@computed_region_ny2h_ckbz"=>"485", :":@computed_region_c8ar_jsdj"=>"67", :":@computed_region_ikxf_gfzr"=>"1953"}
    end
  
    it 'contains expected values for a facility_record with name Alton' do
      raw_location_data = @mo_dmv_office_locations.find { |facility| facility[:name] == "Alton" }
  
      expect(raw_location_data[:phone]).to eq("(417) 778-2004")
      expect(raw_location_data[:address1]).to eq("#26 Court Square")
      expect(raw_location_data[:city]).to eq("Alton")
      expect(raw_location_data[:state]).to eq("MO")
      expect(raw_location_data[:zipcode]).to eq("65606")

      # inspect_raw_location_data_3 = @mo_dmv_office_locations.find { |facility| facility[:dmv_office] == "Alton" }
      # puts inspect_raw_location_data_3
      #=> {:number=>"085", :dorregionnumber=>"13", :type=>"1MV", :name=>"Alton", :address1=>"#26 Court Square", :city=>"Alton", :state=>"MO", :zipcode=>"65606", :phone=>"(417) 778-2004", :fax=>"(417) 778-2003",
      # :size=>"2", :email=>"alton.licenseoffice@lo.mo.gov", :agent=>"Davis Bookkeeping & Tax Service", :officemanager=>"Freda Davis", :contractmanager=>"Freda Davis",
      # :daysopen=>"Monday - Friday 9:00-4:30", :daysclosed=>"Monday - Friday 12:00-1:00",
      # :holidaysclosed=> "Thanksgiving (11/28/2024), Christmas (12/25/2024), New Year's Day (1/1/2025), Martin Luther King Jr. Day (1/20/2025), Lincoln's Birthday (2/12/2025), President's Day (2/17/2025), Truman's Birthday (5/8/2025), Memorial Day (5/26/2025), Juneteenth (6/19/2025), Independence Day (7/04/2025), Labor Day (9/1/2025), Columbus Day (10/13/2025), Veteran's Day (11/11/2025), Thanksgiving (11/27/2025), Christmas (12/25/2025)",
      # :additionaldaysclosed=>"11/29/2024, 12/26/2024, 12/27/2024, 5/23/2025, 6/20/2025, 11/28/2025, 12/26/2025, 12/17/2024, 1/10/2025, 2/18/2025, 2/19/2025", :latlng=>{:latitude=>"36.694599", :longitude=>"-91.398198"},
      # :facebook_url=>"https://www.facebook.com/oregoncountylo/", :":@computed_region_ny2h_ckbz"=>"454", :":@computed_region_c8ar_jsdj"=>"109", :":@computed_region_ikxf_gfzr"=>"534"}
    end
  
  end


end