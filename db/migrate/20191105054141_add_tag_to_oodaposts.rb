class AddTagToOodaposts < ActiveRecord::Migration[5.2]
  def change
    add_column :oodaposts, :tag, :string
  end
end
