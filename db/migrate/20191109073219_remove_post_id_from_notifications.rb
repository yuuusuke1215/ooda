class RemovePostIdFromNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :post_id, :integer
  end
end
