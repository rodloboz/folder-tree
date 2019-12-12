class List < ApplicationRecord
  has_many :items
  has_many :products, through: :items

  def basket_price
    products.sum(:price_cents)
  end

  def supermarkets_by_total_matches
    ids = products.pluck(:id)
    Supermarket.joins(:products)
                 .where(products: { id: ids })
                 .group("supermarkets.id")
                 .order(Arel.sql("count(supermarkets.id) DESC"))
  end

  def supermarkets_by_total_price
    ids = products.pluck(:id)
    Supermarket.joins(:products)
               .where(products: { id: ids })
               .group("supermarkets.id")
               .having("count(supermarkets.id) > #{ids.size / 2}")
               .order(Arel.sql("sum(products.price_cents)"))
  end

  def supermarkets_by_average_price
    ids = products.pluck(:id)
    Supermarket.joins(:products)
               .where(products: { id: ids })
               .group("supermarkets.id")
               .having("count(supermarkets.id) > #{ids.size / 2}")
               .order(Arel.sql("sum(products.price_cents)"))
  end
end
