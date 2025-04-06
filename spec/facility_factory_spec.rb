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

    #printing return value for the first element in the @co_facilities array to make sure it works
    p @co_dmv_office_locations[0]

    #printing the return value for all of the keys within the hash of the first facility record element in the @co_facilities array to make sure the mapping logic is using the correct keys
    p @cco_dmv_office_locations[0].keys
  end
  
  it 'creates facility objects from external data source' do
    @facilities = factory.create_facilities(@cco_dmv_office_locations)

    expect(@facilities).to be_an(Array)
    expect(@facilities[0]).to be_a(Facility)
    
    end

  
end