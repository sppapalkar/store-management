class AddForeignKeyToItems < ActiveRecord::Migration[6.0]
  def self.up
    add_reference :items, :category, index: true, foreign_key: true
  end
  def self.down
    remove_reference :items, :category, index: true, foreign_key: true
  end
end
