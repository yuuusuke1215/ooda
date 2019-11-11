class Oodapost < ApplicationRecord
  belongs_to :user
  
  mount_uploader :image, ImageUploader
  
  validates :observe, presence: true, length: { maximum: 700 }
  validates :orient, presence: true, length: { maximum: 700 }
  validates :decide, presence: true, length: { maximum: 700 }
  validates :act, presence: true, length: { maximum: 700 }
  validates :title, presence: true, length: { maximum: 255 }
  
  has_many :reverses_of_favorite, class_name: 'Favorite'
  has_many :likable, through: :reverses_of_favorite, source: :user
  
  has_many :comments, dependent: :destroy
  
  has_many :notifications, dependent: :destroy
  
  def favoritedPost?(favoritedUser)
    self.likable.include?(favoritedUser)
  end
  
  def self.search(search)
    return Oodapost.all unless search
    Oodapost.where(['title LIKE ?', "%#{search}%"])
  end
  
  def create_notification_like!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and oodapost_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        oodapost_id: id,
        visited_id: user_id,
        action: 'like'
      )
      if notification.visitor_id == notification.visited_id 
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(oodapost_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end
  
  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      oodapost_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
