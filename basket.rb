class Basket
  def initialize(product_catalogue, delivery_charge, offers = [])
    @product_catalogue = product_catalogue
    @delivery_charge = delivery_charge
    @offers = offers
    @basket_items = []
  end

  def add(product_code)
    product = @product_catalogue.find_product(product_code)
    raise "Product not found: #{product_code}" unless product
    @basket_items << product
  end

  def total
    gross_total = @basket_items.sum(&:price)
    discount = @offers.sum { |offer| offer.apply(@basket_items) }
    net_total = gross_total - discount
    delivery = @delivery_charge.calculate(net_total)
    
    (net_total + delivery).floor(2)
  end
end
