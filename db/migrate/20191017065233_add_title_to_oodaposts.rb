class AddTitleToOodaposts < ActiveRecord::Migration[5.2]
  def change
    add_column :oodaposts, :title, :string
  end
end
