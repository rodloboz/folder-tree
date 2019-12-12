class Supermarket < ApplicationRecord
  has_many :supermarket_products
  has_many :products, through: :supermarket_products

  def basket_total_price(ids)
    products.where(products: { id: ids })
            .sum("products.price_cents")
  end

  def basket_average_price(ids)
    products.where(products: { id: ids })
            .average("products.price_cents")
  end

  def total_matches(ids)
    products.where(products: { id: ids }).count
  end
end
