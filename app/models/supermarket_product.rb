class SupermarketProduct < ApplicationRecord
  belongs_to :product
  belongs_to :supermarket

  validates :product, uniqueness: { scope: :supermarket }
end
