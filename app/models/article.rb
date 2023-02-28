class Article < ApplicationRecord
    validates :title, presence:true,length: {minimum:3, maximum:45}
    validates :body, presence:true , length: {minimum:1, maximu:300}
    belongs_to :user

    has_rich_text :body

    has_many :comments , dependent: :destroy

    has_noticed_notifications model_name: "Notification"
    has_many :notifications, through: :user, dependent: :destroy
end
