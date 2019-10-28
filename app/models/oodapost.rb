class Oodapost < ApplicationRecord
  belongs_to :user
  
  validates :observe, presence: true, length: { maximum: 700 }
  validates :orient, presence: true, length: { maximum: 700 }
  validates :decide, presence: true, length: { maximum: 700 }
  validates :act, presence: true, length: { maximum: 700 }
  validates :title, presence: true, length: { maximum: 255 }
  
  has_many :reverses_of_favorite, class_name: 'Favorite'
  has_many :likable, through: :reverses_of_favorite, source: :user
  
  def favoritedPost?(favoritedUser)
    self.likable.include?(favoritedUser)
  end
  
  def self.search(search)
    return Oodapost.all unless search
    Oodapost.where(['title LIKE ?', "%#{search}%"])
  end
end
