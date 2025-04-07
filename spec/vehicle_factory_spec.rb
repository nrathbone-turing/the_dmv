require 'spec_helper'

RSpec.describe VehicleFactory do

  before(:each) do
    @vehicle_factory = VehicleFactory.new
    @wa_ev_registrations = DmvDataService.new.wa_ev_registrations
    
    #for testing multiple elements at different index positions; this should avoid the first/last element and randomly pick one from the remaining elements
    #@random_middle_index = rand(1..@wa_ev_registrations.length - 2)
    #pry(main)> @random_middle_index
    #=> 480
  end

  it 'exists' do
    expect(@vehicle_factory).to be_an_instance_of(VehicleFactory)
    
    # @wa_ev_registrations is an array of hashes, where each hash represents an individual vehicle record
    #from the Washington State EV Vehicle Registration external data source
    expect(@wa_ev_registrations).to be_an(Array)

    #printing the return value for all of the keys used by any hash within the array of vehicle hashes to make sure I am accounting for other differences that may exist between first element and others
    #pry(main)> @wa_ev_registrations.flat_map { |vehicle_record| vehicle_record.keys }.uniq
    #=> [:electric_vehicle_type, :vin_1_10, :dol_vehicle_id, :model_year, :make, :model, :vehicle_primary_use, :electric_range, :odometer_reading, :odometer_code, :new_or_used_vehicle,
    # :sale_price, :date_of_vehicle_sale, :base_msrp, :transaction_type, :transaction_date, :transaction_year, :county, :city, :state_of_residence, :zip,
    # :hb_2042_clean_alternative_fuel_vehicle_cafv_eligibility, :meets_2019_hb_2042_electric_range_requirement, :meets_2019_hb_2042_sale_date_requirement,
    # :meets_2019_hb_2042_sale_price_value_requirement, :_2019_hb_2042_battery_range_requirement, :_2019_hb_2042_purchase_date_requirement, :_2019_hb_2042_sale_price_value_requirement,
    # :electric_vehicle_fee_paid, :transportation_electrification_fee_paid, :hybrid_vehicle_electrification_fee_paid, :census_tract_2020, :legislative_district, :electric_utility]
    
    #testing the first element (vehicle hash)
    expect(@wa_ev_registrations[0][:vin_1_10]).to eq("5YJYGDED6M")
    expect(@wa_ev_registrations[0][:model_year]).to eq("2021")
    expect(@wa_ev_registrations[0][:make]).to eq("TESLA")
    expect(@wa_ev_registrations[0][:model]).to eq("Model Y")

    #printing return value for the first element in the @wa_ev_registrations array to make sure it works
    #pry(main)>@wa_ev_registrations[0]
    #=> {:electric_vehicle_type=>"Battery Electric Vehicle (BEV)", :vin_1_10=>"5YJYGDED6M", :dol_vehicle_id=>"144905659", :model_year=>"2021", :make=>"TESLA", :model=>"Model Y", 
    # :vehicle_primary_use=>"Passenger", :electric_range=>"0", :odometer_reading=>"15", :odometer_code=>"Actual Mileage", :new_or_used_vehicle=>"New", :sale_price=>"44290.00", 
    # :date_of_vehicle_sale=>"2021-02-19T00:00:00.000", :base_msrp=>"0", :transaction_type=>"Original Title", :transaction_date=>"2021-03-09T00:00:00.000", :transaction_year=>"2021", 
    # :county=>"King", :city=>"REDMOND", :state_of_residence=>"WA", :zip=>"98052", :hb_2042_clean_alternative_fuel_vehicle_cafv_eligibility=>"Clean Alternative Fuel Vehicle", 
    # :meets_2019_hb_2042_electric_range_requirement=>true, :meets_2019_hb_2042_sale_date_requirement=>true, :meets_2019_hb_2042_sale_price_value_requirement=>true, 
    # :_2019_hb_2042_battery_range_requirement=>"Battery range requirement is met", :_2019_hb_2042_purchase_date_requirement=>"Purchase date requirement is met", 
    # :_2019_hb_2042_sale_price_value_requirement=>"Sale price/value requirement is met", :electric_vehicle_fee_paid=>"Not Applicable", :transportation_electrification_fee_paid=>"Not Applicable", 
    # :hybrid_vehicle_electrification_fee_paid=>"Not Applicable", :census_tract_2020=>"53033032330", :legislative_district=>"45", :electric_utility=>"PUGET SOUND ENERGY INC||CITY OF TACOMA - (WA)"}
    
    #testing the last element (vehicle hash)
    expect(@wa_ev_registrations[-1][:vin_1_10]).to eq("KMUKCDTC1P")
    expect(@wa_ev_registrations[-1][:model_year]).to eq("2023")
    expect(@wa_ev_registrations[-1][:make]).to eq("GENESIS")
    expect(@wa_ev_registrations[-1][:model]).to eq("GV60")

    #pry(main)> @wa_ev_registrations[-1]
    #=> {:electric_vehicle_type=>"Battery Electric Vehicle (BEV)", :vin_1_10=>"KMUKCDTC1P", :dol_vehicle_id=>"264827307", :model_year=>"2023", :make=>"GENESIS", :model=>"GV60",
    # :vehicle_primary_use=>"Passenger", :electric_range=>"0", :odometer_reading=>"0", :odometer_code=>"Odometer reading is not collected at time of renewal", :new_or_used_vehicle=>"Used",
    # :sale_price=>"0.00", :base_msrp=>"0", :transaction_type=>"Original Registration", :transaction_date=>"2024-03-21T00:00:00.000", :transaction_year=>"2024", 
    # :county=>"Thurston", :city=>"OLYMPIA", :state_of_residence=>"WA", :zip=>"98506", :hb_2042_clean_alternative_fuel_vehicle_cafv_eligibility=>"HB 2042 Eligibility Requirements not met", 
    # :meets_2019_hb_2042_electric_range_requirement=>true, :meets_2019_hb_2042_sale_date_requirement=>false, :meets_2019_hb_2042_sale_price_value_requirement=>false, 
    # :_2019_hb_2042_battery_range_requirement=>"Battery range requirement is met", :_2019_hb_2042_purchase_date_requirement=>"This transaction type is not eligible for the tax exemption", 
    # :_2019_hb_2042_sale_price_value_requirement=>"This transaction type is not eligible for the tax exemption", :electric_vehicle_fee_paid=>"No", :transportation_electrification_fee_paid=>"No", 
    # :hybrid_vehicle_electrification_fee_paid=>"No", :census_tract_2020=>"53067010200", :legislative_district=>"22", :electric_utility=>"PUGET SOUND ENERGY INC"}

    #testing a random middle index element (vehicle hash)
    @random_middle_index = 480
    
    #pry(main)> @wa_ev_registrations[@random_middle_index]
    #=> {:electric_vehicle_type=>"Battery Electric Vehicle (BEV)", :vin_1_10=>"1FT6W1EV7P", :dol_vehicle_id=>"230684212", :model_year=>"2023", :make=>"FORD", :model=>"F-150", 
    # :vehicle_primary_use=>"Commercial", :electric_range=>"0", :odometer_reading=>"0", :odometer_code=>"Odometer reading is not collected at time of renewal", :new_or_used_vehicle=>"Used", 
    # :sale_price=>"0.00", :base_msrp=>"0", :transaction_type=>"Registration Renewal", :transaction_date=>"2025-02-04T00:00:00.000", :transaction_year=>"2025", 
    # :county=>"Clark", :city=>"WASHOUGAL", :state_of_residence=>"WA", :zip=>"98671", :hb_2042_clean_alternative_fuel_vehicle_cafv_eligibility=>"HB 2042 Eligibility Requirements not met", 
    # :meets_2019_hb_2042_electric_range_requirement=>true, :meets_2019_hb_2042_sale_date_requirement=>false, :meets_2019_hb_2042_sale_price_value_requirement=>false, 
    # :_2019_hb_2042_battery_range_requirement=>"Battery range requirement is met", :_2019_hb_2042_purchase_date_requirement=>"This transaction type is not eligible for the tax exemption", 
    # :_2019_hb_2042_sale_price_value_requirement=>"This transaction type is not eligible for the tax exemption", :electric_vehicle_fee_paid=>"Yes", :transportation_electrification_fee_paid=>"Yes", 
    # :hybrid_vehicle_electrification_fee_paid=>"No", :census_tract_2020=>"53011040605", :legislative_district=>"18", :electric_utility=>"BONNEVILLE POWER ADMINISTRATION||PUD NO 1 OF CLARK COUNTY - (WA)"}
    
    expect(@wa_ev_registrations[@random_middle_index][:vin_1_10]).to eq("1FT6W1EV7P")
    expect(@wa_ev_registrations[@random_middle_index][:model_year]).to eq("2023")
    expect(@wa_ev_registrations[@random_middle_index][:make]).to eq("FORD")
    expect(@wa_ev_registrations[@random_middle_index][:model]).to eq("F-150")

  end

  it 'creates vehicle objects from external data source' do
    vehicles = @vehicle_factory.create_vehicles(@wa_ev_registrations)

    expect(vehicles).to be_an(Array)
    expect(vehicles[0]).to be_a(Vehicle)

    #p vehicles[0]
    #=> #<Vehicle:0x0000000104531a60 @vin="5YJYGDED6M", @year="2021", @make="TESLA", @model="Model Y", @engine=:ev, @registration_date=nil, @plate_type=nil>

    #printing the return value for all of the keys used by any hash within the array of vehicle hashes to make sure I am accounting for other differences that may exist between first element and others
    #p @wa_ev_registrations.flat_map { |vehicle_record| vehicle_record.keys }.uniq
    #=> [:electric_vehicle_type, :vin_1_10, :dol_vehicle_id, :model_year, :make, :model, :vehicle_primary_use, :electric_range, :odometer_reading, :odometer_code, :new_or_used_vehicle,
    # :sale_price, :date_of_vehicle_sale, :base_msrp, :transaction_type, :transaction_date, :transaction_year, :county, :city, :state_of_residence, :zip,
    # :hb_2042_clean_alternative_fuel_vehicle_cafv_eligibility, :meets_2019_hb_2042_electric_range_requirement, :meets_2019_hb_2042_sale_date_requirement,
    # :meets_2019_hb_2042_sale_price_value_requirement, :_2019_hb_2042_battery_range_requirement, :_2019_hb_2042_purchase_date_requirement, :_2019_hb_2042_sale_price_value_requirement,
    # :electric_vehicle_fee_paid, :transportation_electrification_fee_paid, :hybrid_vehicle_electrification_fee_paid, :census_tract_2020, :legislative_district, :electric_utility]

    expect(vehicles[0].vin).to eq(@wa_ev_registrations[0][:vin_1_10])
    expect(vehicles[0].make).to eq(@wa_ev_registrations[0][:make])
    expect(vehicles[0].model).to eq(@wa_ev_registrations[0][:model])
    expect(vehicles[0].year).to eq(@wa_ev_registrations[0][:model_year])
    expect(vehicles[0].engine).to eq(:ev)

    #printing the return value for all of the keys within the hash of the first vehicle record element in the @wa_ev_registrations array to make sure the mapping is using the correct keys
    #p @wa_ev_registrations[0].keys
    #=> [:electric_vehicle_type, :vin_1_10, :dol_vehicle_id, :model_year, :make, :model, :vehicle_primary_use, :electric_range, :odometer_reading, :odometer_code,
    # :new_or_used_vehicle, :sale_price, :date_of_vehicle_sale, :base_msrp, :transaction_type, :transaction_date, :transaction_year, 
    # :county, :city, :state_of_residence, :zip, :hb_2042_clean_alternative_fuel_vehicle_cafv_eligibility, :meets_2019_hb_2042_electric_range_requirement, 
    # :meets_2019_hb_2042_sale_date_requirement, :meets_2019_hb_2042_sale_price_value_requirement, :_2019_hb_2042_battery_range_requirement, 
    # :_2019_hb_2042_purchase_date_requirement, :_2019_hb_2042_sale_price_value_requirement, :electric_vehicle_fee_paid, :transportation_electrification_fee_paid, 
    # :hybrid_vehicle_electrification_fee_paid, :census_tract_2020, :legislative_district, :electric_utility]
    
    #since the external database is made up of only electric vehicles, we're hard-coding the :engine value as :ev for each vehicle created in the vehicle factory
    #when we pass that value (:engine => :ev) into the hash used for each new Vehicle object, it becomes part of the vehicle_details hash argument that gets passed into the Vehicle class's initialize method
    #and because we assign that value to an instance variable within that initialize method (@engine = vehicle_details[:engine]), and because the create_vehicles method in the VehicleFactory class returns an array of Vehicle objects,
    #we can call the .engine method on any Vehicle object in that array, accessing the @engine instance variable and returning a value of :ev
    expect(vehicles[0].engine).to eq(:ev)
    
  end


end