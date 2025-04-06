require 'spec_helper'
#binding.pry
RSpec.describe VehicleFactory do

  before(:each) do
    @factory = VehicleFactory.new
    @wa_ev_registrations = DmvDataService.new.wa_ev_registrations
  end

  it 'exists' do
    expect(@factory).to be_an_instance_of(VehicleFactory)
    
    # @wa_ev_registrations is an array of hashes, where each hash represents an individual vehicle record
    #from the Washington State EV Vehicle Registration external data source
    expect(@wa_ev_registrations).to be_an(Array)

    #printing return value for the first element in the @wa_ev_registrations array to make sure it works
    #p @wa_ev_registrations[0]
    #=> {:electric_vehicle_type=>"Battery Electric Vehicle (BEV)", :vin_1_10=>"5YJYGDED6M", :dol_vehicle_id=>"144905659", :model_year=>"2021", :make=>"TESLA", :model=>"Model Y", 
    # :vehicle_primary_use=>"Passenger", :electric_range=>"0", :odometer_reading=>"15", :odometer_code=>"Actual Mileage", :new_or_used_vehicle=>"New", :sale_price=>"44290.00", 
    # :date_of_vehicle_sale=>"2021-02-19T00:00:00.000", :base_msrp=>"0", :transaction_type=>"Original Title", :transaction_date=>"2021-03-09T00:00:00.000", :transaction_year=>"2021", 
    # :county=>"King", :city=>"REDMOND", :state_of_residence=>"WA", :zip=>"98052", :hb_2042_clean_alternative_fuel_vehicle_cafv_eligibility=>"Clean Alternative Fuel Vehicle", 
    # :meets_2019_hb_2042_electric_range_requirement=>true, :meets_2019_hb_2042_sale_date_requirement=>true, :meets_2019_hb_2042_sale_price_value_requirement=>true, 
    # :_2019_hb_2042_battery_range_requirement=>"Battery range requirement is met", :_2019_hb_2042_purchase_date_requirement=>"Purchase date requirement is met", 
    # :_2019_hb_2042_sale_price_value_requirement=>"Sale price/value requirement is met", :electric_vehicle_fee_paid=>"Not Applicable", :transportation_electrification_fee_paid=>"Not Applicable", 
    # :hybrid_vehicle_electrification_fee_paid=>"Not Applicable", :census_tract_2020=>"53033032330", :legislative_district=>"45", :electric_utility=>"PUGET SOUND ENERGY INC||CITY OF TACOMA - (WA)"}
    
    #printing the return value for all of the keys within the hash of the first vehicle record element in the @wa_ev_registrations array to make sure the mapping is using the correct keys
    #p @wa_ev_registrations[0].keys
    #=> [:electric_vehicle_type, :vin_1_10, :dol_vehicle_id, :model_year, :make, :model, :vehicle_primary_use, :electric_range, :odometer_reading, :odometer_code,
    # :new_or_used_vehicle, :sale_price, :date_of_vehicle_sale, :base_msrp, :transaction_type, :transaction_date, :transaction_year, 
    # :county, :city, :state_of_residence, :zip, :hb_2042_clean_alternative_fuel_vehicle_cafv_eligibility, :meets_2019_hb_2042_electric_range_requirement, 
    # :meets_2019_hb_2042_sale_date_requirement, :meets_2019_hb_2042_sale_price_value_requirement, :_2019_hb_2042_battery_range_requirement, 
    # :_2019_hb_2042_purchase_date_requirement, :_2019_hb_2042_sale_price_value_requirement, :electric_vehicle_fee_paid, :transportation_electrification_fee_paid, 
    # :hybrid_vehicle_electrification_fee_paid, :census_tract_2020, :legislative_district, :electric_utility]
    
  end

  it 'creates vehicle objects from external data source' do
    vehicles = @factory.create_vehicles(@wa_ev_registrations)

    expect(vehicles).to be_an(Array)
    expect(vehicles[0]).to be_a(Vehicle)

    #p vehicles[0]
    #=> #<Vehicle:0x0000000104531a60 @vin="5YJYGDED6M", @year="2021", @make="TESLA", @model="Model Y", @engine=:ev, @registration_date=nil, @plate_type=nil>

    #since the external database is made up of only electric vehicles, we're hard-coding the :engine value as :ev for each vehicle created in the vehicle factory
    #when we pass that value (:engine => :ev) into the hash used for each new Vehicle object, it becomes part of the vehicle_details hash argument that gets passed into the Vehicle class's initialize method
    #and because we assign that value to an instance variable within that initialize method (@engine = vehicle_details[:engine]), and because the create_vehicles method in the VehicleFactory class returns an array of Vehicle objects,
    #we can call the .engine method on any Vehicle object in that array, accessing the @engine instance variable and returning a value of :ev
    expect(vehicles[0].engine).to eq(:ev)
    
  end


end