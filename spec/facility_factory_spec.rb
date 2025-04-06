require 'spec_helper'

RSpec.describe FacilityFactory do
  
  before(:each) do
    @facility_factory = FacilityFactory.new
    @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
  end

  it 'exists' do
    expect(@facility_factory).to be_an_instance_of(FacilityFactory)
    
    #@co_facilities is an array of hashes, where each hash represents an individual facility record
    #from the Colorado DMV Office Locations external data source
    expect(@co_dmv_office_locations).to be_an(Array)

    #printing return value for the first element in the @co_dmv_office_locations array to make sure it works
    p @co_dmv_office_locations[0]
    #=> {:the_geom=>{:type=>"Point", :coordinates=>[-104.97443112500002, 39.75525297420336]}, :dmv_id=>"1", :dmv_office=>"DMV Tremont Branch",
    # :address_li=>"2855 Tremont Place", :address__1=>"Suite 118", :city=>"Denver", :state=>"CO", :zip=>"80205", :phone=>"(720) 865-4600",
    # :hours=>"Mon, Tue, Thur, Fri  8:00 a.m.- 4:30 p.m. / Wed 8:30 a.m.-4:30 p.m.", :services_p=>"vehicle titles, registration, renewals; VIN inspections",
    # :parking_no=>"parking available in the lot at the back of the bldg (Glenarm Street)", :photo=>"images/Tremont.jpg", :address_id=>"175164", :":@computed_region_nku6_53ud"=>"1444"}
    #binding.pry
    #printing the return value for all of the keys within the hash of the first facility record element in the @co_dmv_office_locations array to make sure the mapping logic is using the correct keys
    p @co_dmv_office_locations[0].keys
    #=> [:the_geom, :dmv_id, :dmv_office, :address_li, :address__1, :city, :state, :zip, :phone, :hours, :services_p, :parking_no, :photo, :address_id, :":@computed_region_nku6_53ud"]
  end
  
  it 'creates facility objects from external data source' do
    @facilities = @facility_factory.create_facilities(@co_dmv_office_locations)

    expect(@facilities).to be_an(Array)
    expect(@facilities[0]).to be_a(Facility)

    p @facilities[0]
    #=> #<Facility:0x0000000105be2598 @name="DMV Tremont Branch", @address="address_li address_1 city state zip", @phone="(720) 865-4600", @services=[], @registered_vehicles=[], @collected_fees=0>
    end

  
end