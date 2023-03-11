class Article < ApplicationRecord
  extend FriendlyId

    validates :title, presence:true,length: {minimum:3, maximum:45}
    validates :body, presence:true , length: {minimum:1, maximu:300}
    belongs_to :user
    belongs_to :category
    has_rich_text :body
    has_many_attached :pictures
    has_many :comments , dependent: :destroy

    has_noticed_notifications model_name: "Notification"
    has_many :notifications, through: :user

    friendly_id :title, use: %i[slugged history finders] # history to save old urls and redirect to the new url and finder here instead to change all article.friendly.find(params[:id]) and just become article.find(params[:id])

    def should_generate_new_friendly_id?
      title_changed? || slug.blank?
    end

    def views_by_day
      daily_events = Ahoy::Event.where("cast(properties ->> 'article_id' as bigint) = ?", id)
      daily_events.group_by_day(:time, range: 1.month.ago..Time.now).count
    end

    def self.total_views_by_day
      daily_events = Ahoy::Event.where(name: "Viewed article")
      daily_events.group_by_day(:time, range: 1.month.ago..Time.now).count
    end


end
