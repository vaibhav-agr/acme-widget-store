require_relative 'offer'

class BuyOneGetSecondHalfPrice < Offer
  def initialize(product_code)
    @product_code = product_code
  end

  def apply(items)
    matching_items = items.select { |item| item.code == @product_code }
    return 0 if matching_items.length < 2
    
    # for every second item, slash price by half
    pairs = matching_items.length / 2
    discount_per_pair = matching_items.first.price * 0.5
    puts "pairs #{pairs} discount_per_pair #{discount_per_pair}"
    pairs * discount_per_pair
  end
end