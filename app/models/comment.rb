class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :oodapost
  
  has_many :notifications, dependent: :destroy
  
  validates :content, presence: true, length: { maximum: 700 }
end
