class AddPublishedAtToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :published_at, :datetime,  null: false, default: Time.now
  end
end
