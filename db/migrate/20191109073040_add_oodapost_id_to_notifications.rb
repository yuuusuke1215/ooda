class AddOodapostIdToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :oodapost_id, :integer
  end
end
