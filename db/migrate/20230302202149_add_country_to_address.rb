class AddCountryToAddress < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :country, :string
  end
end
