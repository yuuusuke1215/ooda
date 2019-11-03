class AddImageToOodaposts < ActiveRecord::Migration[5.2]
  def change
    add_column :oodaposts, :image, :string
  end
end
