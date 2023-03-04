class RemoveCounteryFromAddresses < ActiveRecord::Migration[7.0]
  def change
    remove_column :addresses, :countery, :string
  end
end
