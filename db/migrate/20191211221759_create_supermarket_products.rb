class CreateSupermarketProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :supermarket_products do |t|
      t.references :product, foreign_key: true
      t.references :supermarket, foreign_key: true

      t.timestamps
    end
  end
end
