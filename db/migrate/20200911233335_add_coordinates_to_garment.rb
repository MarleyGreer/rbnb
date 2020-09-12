class AddCoordinatesToGarment < ActiveRecord::Migration[6.0]
  def change
    add_column :garments, :latitude, :float
    add_column :garments, :longitude, :float
  end
end
