class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :number
      t.string :cvv
      t.integer :expiry_mm
      t.integer :expiry_yy

      t.timestamps
    end
  end
end
