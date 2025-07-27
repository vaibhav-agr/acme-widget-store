require 'minitest/autorun'
require_relative '../product'
require_relative '../product_catalogue'
require_relative '../delivery_charge'
require_relative '../buy_one_get_second_half_price'
require_relative '../basket'

class BasketTest < Minitest::Test
  def setup
    product_catalogue = [
      Product.new('B01', 'Blue Widget', 7.95),
      Product.new('G01', 'Green Widget', 24.95),
      Product.new('R01', 'Red Widget', 32.95)
    ]
    @product_catalogue = ProductCatalogue.new(product_catalogue)

    @delivery_rules = [
      { min_amount: 90, charge: 0 },
      { min_amount: 50, charge: 2.95 },
      { min_amount: 0, charge: 4.95 }
    ]
    @delivery_charge = DeliveryCharge.new(@delivery_rules)

    @offers = [BuyOneGetSecondHalfPrice.new('R01')]
    
    @basket = Basket.new(@product_catalogue, @delivery_charge, @offers)
  end

  def test_invalid_product_code
    assert_raises(RuntimeError) { @basket.add('ABC') }
  end

  def test_single_item_with_delivery
    @basket.add('B01')
    assert_equal 12.90, @basket.total  # 7.95 + 4.95 delivery
  end

  def test_no_discount_for_single_red_widget
    @basket.add('R01')
    assert_equal 37.90, @basket.total  # 32.95 + 4.95 delivery
  end

  def test_three_red_widgets
    3.times { @basket.add('R01') }
    assert_equal 85.32, @basket.total  # (32.95 * 3) - 16.475 discount + 2.95 delivery = 98.27
  end

  def test_basket_b01_g01
    @basket.add('B01')
    @basket.add('G01')
    assert_equal 37.85, @basket.total # 7.95 + 24.95 + 4.95 delivery = 37.85
  end

  def test_basket_r01_r01
    @basket.add('R01')
    @basket.add('R01')
    assert_equal 54.37, @basket.total # 32.95 + (32.95/2) + 4.95 delivery = 54.37
  end

  def test_basket_r01_g01
    @basket.add('R01')
    @basket.add('G01')
    assert_equal 60.85, @basket.total # 32.95 + 24.95 + 2.95 delivery = 60.85
  end

  def test_basket_multiple_items
    @basket.add('B01')
    @basket.add('B01')
    @basket.add('R01')
    @basket.add('R01')
    @basket.add('R01')
    assert_equal 98.27, @basket.total # (7.95 * 2) + (32.95 * 3) - 16.475 discount = 98.27
  end

  def test_multiple_offers
    offers = [
      BuyOneGetSecondHalfPrice.new('R01'),
      BuyOneGetSecondHalfPrice.new('G01')
    ]
    basket = Basket.new(@product_catalogue, @delivery_charge, offers)

    2.times { basket.add('R01') }  # 32.95 * 2 - 16.475 = 49.425
    2.times { basket.add('G01') }  # 24.95 * 2 - 12.475 = 37.425
    basket.add('B01')              # 7.95

    assert_equal 94.80, basket.total # 49.425 + 37.425 + 7.95 = 94.80
  end
end
