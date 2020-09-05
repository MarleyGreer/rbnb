class CreateGarments < ActiveRecord::Migration[6.0]
  def change
    create_table :garments do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.string :category
      t.integer :size
      t.string :colour
      t.text :address
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
