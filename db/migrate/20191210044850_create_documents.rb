class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.references :folder, foreign_key: true
      t.string :attachment

      t.timestamps
    end
  end
end
