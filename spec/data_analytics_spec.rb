require 'spec_helper'

RSpec.describe DataAnalytics do

  before(:each) do

    @vehicle_factory = VehicleFactory.new
    @wa_ev_registrations = DmvDataService.new.wa_ev_registrations

    @facility_factory = FacilityFactory.new
    @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
    @ny_dmv_office_locations = DmvDataService.new.ny_dmv_office_locations
    @mo_dmv_office_locations = DmvDataService.new.mo_dmv_office_locations

    @colorado_facilities = @facility_factory.create_co_facilities(@co_dmv_office_locations)
    @new_york_facilities = @facility_factory.create_ny_facilities(@ny_dmv_office_locations)
    @missouri_facilities = @facility_factory.create_mo_facilities(@mo_dmv_office_locations)
  end

  it 'exists' do
    expect(@vehicle_factory).to be_an_instance_of(VehicleFactory)
    expect(@wa_ev_registrations).to be_an(Array)
    expect(@facility_factory).to be_an_instance_of(FacilityFactory)
    expect(@co_dmv_office_locations).to be_an(Array)

  end

end