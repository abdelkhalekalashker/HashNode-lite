class PublishArticleJob < ApplicationJob
  queue_as :default

  def perform(article)
    article.publish!
  end
end
