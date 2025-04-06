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
    # from the Washington State EV Vehicle Registration external data source
    expect(@wa_ev_registrations).to be_an(Array)
  end

  it 'creates vehicle objects from external data source' do
    vehicles = @factory.create_vehicles(@wa_ev_registrations)

    expect(vehicles).to be_an(Array)
    expect(vehicles[0]).to be_a(Vehicle)

    #since the external database is made up of only electric vehicles, we're hard-coding the :engine value as :ev for each vehicle created in the vehicle factory
    #when we pass that value (:engine => :ev) into the hash used for each new Vehicle object, it becomes part of the vehicle_details hash argument that gets passed into the Vehicle class's initialize method
    #and because we assign that value to an instance variable within that initialize method (@engine = vehicle_details[:engine]), and because the create_vehicles method in the VehicleFactory class returns an array of Vehicle objects,
    #we can call the .engine method on any Vehicle object in that array, accessing the @engine instance variable and returning a value of :ev
    expect(vehicles[0].engine).to eq(:ev)
  end


end