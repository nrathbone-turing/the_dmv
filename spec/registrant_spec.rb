require 'spec_helper'
require './lib/registrant'

RSpec.describe Registrant do

  before(:each) do
    @registrant_1 = Registrant.new('Bruce', 18, true )
    @registrant_2 = Registrant.new('Penny', 15 )
  end

  describe 'registrant_1' do

    it 'exists' do
      expect(@registrant_1).to be_a(Registrant)
    end

    it 'has the name Bruce' do
      expect(@registrant_1.name).to eq("Bruce")
    end
  
    it 'has the age of 18' do
      expect(@registrant_1.age).to eq(18)
    end
  
    it 'has a permit?' do
      expect(@registrant_1.permit).to eq(true)
    end
   
    it 'has no license data' do
      expect(@registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end

  end
 
  describe 'registrant_2' do

    it 'exists' do
      expect(@registrant_2).to be_a(Registrant)
    end

    it 'has the name Penny' do
      expect(@registrant_2.name).to eq("Penny")
    end
  
    it 'has the age of 15' do
      expect(@registrant_2.age).to eq(15)
    end
  
    it 'has a permit?' do
      expect(@registrant_2.permit).to eq(false)
    end
   
    it 'has no license data' do
      expect(@registrant_2.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end

  end
  
  it 'earns a permit' do
    @registrant_2.earn_permit

    expect(@registrant_2.permit).to eq(true)
  end

end