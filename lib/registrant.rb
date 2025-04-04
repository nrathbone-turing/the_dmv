class Registrant

  attr_reader :name, :age, :permit, :license_data

  def initialize(name, age, permit = false)
    @name = name
    @age = age
    @permit = permit
  end

  def license_data
    {:written=>false, :license=>false, :renewed=>false}
  end

  def earn_permit
    @permit = true
  end
  
end