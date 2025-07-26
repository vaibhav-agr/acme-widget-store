class Product
  attr_reader :code, :price, :name

  def initialize(code, name, price)
    @code = code
    @name = name
    @price = price
  end
end
