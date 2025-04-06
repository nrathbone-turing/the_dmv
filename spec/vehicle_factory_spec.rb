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
    expect(vehicles[0][:engine]).to eq(:ev)
  end


end