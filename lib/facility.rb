class Facility
  attr_reader :name, :address, :phone, :services

  def initialize(facility)
    @name = facility[:name]
    @address = facility[:address]
    @phone = facility[:phone]
    @services = []
  end

  def add_service(service)
    @services << service
  end
end
