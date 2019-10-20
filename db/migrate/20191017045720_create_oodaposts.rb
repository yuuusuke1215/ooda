class CreateOodaposts < ActiveRecord::Migration[5.2]
  def change
    create_table :oodaposts do |t|
      t.string :observe
      t.string :orient
      t.string :decide
      t.string :act
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
