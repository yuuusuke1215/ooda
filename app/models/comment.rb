class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :oodapost
  
  validates :content, presence: true, length: { maximum: 700 }
end
