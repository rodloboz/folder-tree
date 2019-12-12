class CreateFolders < ActiveRecord::Migration[5.2]
  def change
    create_table :folders do |t|
      t.references :folder, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
