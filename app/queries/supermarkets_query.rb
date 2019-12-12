class SupermarketsQuery
  def initialize(list, supermarkets = Supermarket.all)
    @ids = list.products.pluck(:id)
    @supermarkets = supermarkets
  end

  def by_total_matches
    @supermarkets.joins(:products)
                 .where(products: { id: @list.products.pluck(:id) })
                 .group("supermarkets.id")
                 .order(Arel.sql("count(supermarkets.id) DESC"))
  end

  def by_total_price
    @supermarkets.joins(:products)
                 .where(products: { id: @ids })
                 .group("supermarkets.id")
                 .having("count(supermarkets.id) > #{@ids.size / 2}")
                 .order(Arel.sql("sum(products.price_cents)"))
  end

  def by_average_price
    @supermarkets.joins(:products)
                 .where(products: { id: @ids })
                 .group("supermarkets.id")
                 .having("count(supermarkets.id) > #{@ids.size / 2}")
                 .order(Arel.sql("sum(products.price_cents)"))
  end
end

# def supermarkets_by_matched_products
#     Supermarket.joins(:products)
#                .where(products: { id: products.pluck(:id) })
#                .group("supermarkets.id")
#                .order(Arel.sql("count(supermarkets.id) DESC"))
#                # .limit(3)
#   end

#   def supermarkets_by_basket_price
#     Supermarket.joins(:products)
#                .where(products: { id: ids})
#                .group("supermarkets.id")
#                .order(Arel.sql("sum(products.price_cents)"))
#                # .limit(3)
#   end

#   def supermarkets_by_average_price
#     Supermarket.joins(:products)
#                .where(products: { id: ids})
#                .group("supermarkets.id")
#                .order(Arel.sql("sum(products.price_cents)"))
#                # .limit(3)
#   end
