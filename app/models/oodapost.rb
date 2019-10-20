class Oodapost < ApplicationRecord
  belongs_to :user
  
  validates :observe, presence: true, length: { maximum: 700 }
  validates :orient, presence: true, length: { maximum: 700 }
  validates :decide, presence: true, length: { maximum: 700 }
  validates :act, presence: true, length: { maximum: 700 }
  validates :title, presence: true, length: { maximum: 255 }
end
