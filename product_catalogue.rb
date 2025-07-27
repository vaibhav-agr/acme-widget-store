class ProductCatalogue
  def initialize(products)
    # products array
    @products = products
  end

  def find_product(code)
    @products.find { |product| product.code == code }
  end

  # can add more methods to add or remove products from catalogue
end