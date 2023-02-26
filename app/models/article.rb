class Article < ApplicationRecord
    validates :title, presence:true,length: {minimum:3, maximum:45}
    validates :body, presence:true , length: {minimum:1, maximu:300}
    belongs_to :user

    has_many :comments , dependent: :destroy
end