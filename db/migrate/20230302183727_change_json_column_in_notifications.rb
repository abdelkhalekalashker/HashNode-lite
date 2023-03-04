class ChangeJsonColumnInNotifications < ActiveRecord::Migration[7.0]
  def change
      change_column :notifications, :params, :jsonb, using: 'params::jsonb'
      #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
