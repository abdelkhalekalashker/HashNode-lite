class PopulateAarticleCommentsCount < ActiveRecord::Migration[7.0]
  def change
    Article.all.each do |article|
        Article.reset_counters(article.id,:comments)
    end
  end
end
