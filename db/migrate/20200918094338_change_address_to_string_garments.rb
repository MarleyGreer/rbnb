class ChangeAddressToStringGarments < ActiveRecord::Migration[6.0]
  def change
    change_column :garments, :address, :string
  end
end
