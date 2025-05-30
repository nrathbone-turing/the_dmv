require 'spec_helper'

RSpec.describe Facility do
  
  describe '#initialize' do
  
    before(:each) do
    @facility = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})  
    end

    it 'can initialize' do
      expect(@facility).to be_an_instance_of(Facility)
      expect(@facility.name).to eq('DMV Tremont Branch')
      expect(@facility.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility.phone).to eq('(720) 865-4600')
      expect(@facility.services).to eq([])
    end
  end

  describe '#add service' do
  
    before(:each) do
      @facility = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})  
    end
    
    it 'can add available services' do
      expect(@facility.services).to eq([])
      @facility.add_service('New Drivers License')
      @facility.add_service('Renew Drivers License')
      @facility.add_service('Vehicle Registration')
      expect(@facility.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end

  describe '#register_vehicle' do

    before(:each) do
      @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
      @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
  
      @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
      @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
      @camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
    end
    
    it 'exists' do
      expect(@facility_1).to be_an_instance_of(Facility)
      expect(@facility_2).to be_an_instance_of(Facility)
    end
    
    it 'does not register a vehicle if the service is not offered' do
      # based on the note from project instructions:
        # NOTE: A facility must offer a service in order to perform it. 
        # Just because the DMV allows facilities to perform certain services,
        #  does not mean that every facility provides every service.
      
      expect(@facility_1.registered_vehicles).to eq([])
      @facility_1.register_vehicle(@cruz)
      expect(@facility_1.registered_vehicles).to eq([])

      expect(@facility_2.services).to eq([])
      expect(@facility_2.registered_vehicles).to eq([])
      expect(@facility_2.register_vehicle(@bolt)).to eq(nil)
      expect(@facility_2.registered_vehicles).to eq([])
      expect(@facility_2.collected_fees).to eq(0)

    end
    
    it 'adds vehicle to registered_vehicles when registration succeeds' do
      @facility_1.add_service('Vehicle Registration')
      expect(@facility_1.services).to eq(['Vehicle Registration'])

      # facility has not registered any vehicles yet
      expect(@cruz.registration_date).to eq(nil)
      expect(@facility_1.registered_vehicles).to eq([])
    
      @facility_1.register_vehicle(@cruz)
      expect(@facility_1.registered_vehicles).to eq([@cruz])
    end

    it 'sets registration date and plate type' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)

      expect(@cruz.registration_date).to eq(Date.today)
      expect(@cruz.plate_type).to eq(:regular)

      @facility_1.register_vehicle(@camaro)

      expect(@camaro.registration_date).to eq(Date.today)
      expect(@camaro.plate_type).to eq(:antique)

      @facility_1.register_vehicle(@bolt)
      expect(@bolt.registration_date).to eq(Date.today)
      expect(@bolt.plate_type).to eq(:ev)
    end

    it 'adds the correct fee for a regular vehicle' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)
    
      expect(@facility_1.collected_fees).to eq(100)
    end

    it 'adds the correct fee for an antique vehicle' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@camaro)
    
      expect(@facility_1.collected_fees).to eq(25)
    end

    it 'adds the correct fee for an electric vehicle' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@bolt)
    
      expect(@facility_1.collected_fees).to eq(200)
    end
    
    it 'adds all successfully registered vehicles to registered_vehicles' do
      @facility_1.add_service('Vehicle Registration')
         
      @facility_1.register_vehicle(@cruz)
      @facility_1.register_vehicle(@camaro)
      @facility_1.register_vehicle(@bolt)

      expect(@facility_1.registered_vehicles).to eq([@cruz, @camaro, @bolt])
    end

    it 'sums the fees collected for each vehicle in registered_vehicles' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)
      @facility_1.register_vehicle(@camaro)
      @facility_1.register_vehicle(@bolt)
    
      expect(@facility_1.collected_fees).to eq(325)
    end


  end

  describe 'getting a drivers license' do

    before(:each) do
      @registrant_1 = Registrant.new('Bruce', 18, true )
      @registrant_2 = Registrant.new('Penny', 16 )
      @registrant_3 = Registrant.new('Tucker', 15 )

      @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
      @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
    end

    describe '#administer_written_test' do
      
      it 'administers written test correctly based on registrant age and permit status and services offered at that facility' do
        #default state for registrant_1 with permit 
        expect(@registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
        expect(@registrant_1.permit?).to eq(true)
        
        #registrant_1 with permit, but service not yet offered at this facility
        expect(@facility_1.administer_written_test(@registrant_1)).to eq(false)
        expect(@registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})

        #written test service is added to this facility
        @facility_1.add_service('Written Test')
        #=> ["Written Test"]
        
        #registrant_1 passes written test and the license_data is updated to reflect this
        expect(@facility_1.administer_written_test(@registrant_1)).to eq(true)
        expect(@registrant_1.license_data).to eq({:written=>true, :license=>false, :renewed=>false})

        #registrant_2 without permit
        expect(@registrant_2.age).to eq(16)
        expect(@registrant_2.permit?).to eq(false)
        expect(@facility_1.administer_written_test(@registrant_2)).to eq(false)
        
        #registrant_2 with permit
        @registrant_2.earn_permit
        
        expect(@facility_1.administer_written_test(@registrant_2)).to eq(true)
        expect(@registrant_2.license_data).to eq({:written=>true, :license=>false, :renewed=>false})
        
        #registrant_3 too young to earn permit or take written test
        expect(@registrant_3.age).to eq(15)
        expect(@registrant_3.permit?).to eq(false)
        expect(@facility_1.administer_written_test(@registrant_3)).to eq(false)

        @registrant_3.earn_permit

        expect(@facility_1.administer_written_test(@registrant_3)).to eq(false)
        expect(@registrant_3.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
      end
    end

    describe '#administer_road_test' do

      it 'administers road test only after registrant passes and the service is offered at that facility' do
        #registrant_3 is still too young and should not quality for the road test, nor should they be able to earn a permit
        expect(@facility_1.administer_road_test(@registrant_3)).to eq(false)
        @registrant_3.earn_permit

        expect(@facility_1.administer_road_test(@registrant_3)).to eq(false)
        expect(@registrant_3.license_data).to eq({:written=>false, :license=>false, :renewed=>false})

        #registrant_1 with permit and passed written test, but service is not yet offered at this facility
        @facility_1.add_service('Written Test')
        @facility_1.administer_written_test(@registrant_1)
        
        expect(@facility_1.administer_road_test(@registrant_1)).to eq(false)
        
        #road test service is added to this facility
        @facility_1.add_service('Road Test')
        #=> ["Written Test", "Road Test"]

        #registrant_1 passes the road test and the license data is updated to reflect this
        expect(@facility_1.administer_road_test(@registrant_1)).to eq(true)
        expect(@registrant_1.license_data).to eq({:written=>true, :license=>true, :renewed=>false})

        #registrant_2 with permit and passed written test should pass road test and update license_data to reflect this
        @registrant_2.earn_permit
        @facility_1.administer_written_test(@registrant_2)
        
        @facility_1.administer_road_test(@registrant_2)
        expect(@registrant_2.license_data).to eq({:written=>true, :license=>true, :renewed=>false})
      end

    end

    describe 'renews a drivers license' do

      it 'renews license only after registrant has passed the road test and earned a license and the service is offered at that facility' do
        #registrant_1 with passed road test and earned a license, but service is not yet offered at this facility
        @facility_1.add_service('Written Test')
        @facility_1.add_service('Road Test')
        @facility_1.administer_written_test(@registrant_1)
        @facility_1.administer_road_test(@registrant_1)
        
        expect(@facility_1.renew_drivers_license(@registrant_1)).to eq(false)
        
        #renew license service is added to this facility
        @facility_1.add_service('Renew License')
        #=> ["Written Test", "Road Test", "Renew License"]
        
        #registrant_1 has their license renewed and the license_data is updated to reflect this
        expect(@facility_1.renew_drivers_license(@registrant_1)).to eq(true)
        expect(@registrant_1.license_data).to eq({:written=>true, :license=>true, :renewed=>true})

        #registrant_3 is still to young and should not qualify for the permit renewal because they did not pass the road test and earn a license
        expect(@facility_1.renew_drivers_license(@registrant_3)).to eq(false)
        expect(@registrant_3.license_data).to eq({:written=>false, :license=>false, :renewed=>false})

        #registrant_2 also passed both written and road tests, earned a licenese, and had it renewed successfully and the license data is updated to reflect this
        @registrant_2.earn_permit
        @facility_1.administer_written_test(@registrant_2)
        @facility_1.administer_road_test(@registrant_2)
        
        expect(@facility_1.renew_drivers_license(@registrant_2)).to eq(true)
        expect(@registrant_2.license_data).to eq({:written=>true, :license=>true, :renewed=>true})
      end
    end
  end


end
