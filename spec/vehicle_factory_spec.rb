require 'spec_helper'
binding.pry
RSpec.describe VehicleFactory do

  before(:each) do
    @factory = VehicleFactory.new
    @wa_ev_registrations = DmvDataService.new.wa_ev_registrations
  end

  it 'exists' do
    expect(@factory).to be_an_instance_of(VehicleFactory)
    expect(@wa_ev_registrations).to be_an_instance_of(DmvDataService)
  end

  it 'returns a collection of vehicles from external database as an array of hashes' do
    expect(factory.create_vehicles(@wa_ev_registrations)).to eq([])
  end


end