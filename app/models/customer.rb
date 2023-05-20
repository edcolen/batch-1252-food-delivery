class Customer
  attr_accessor :id, :name, :address

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @address = attributes[:address]
  end

  def self.headers
    %w[id name address]
  end

  def to_row
    [@id, @name, @address]
  end
end
