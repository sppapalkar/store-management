class AddForeignKeyToSubscriptions < ActiveRecord::Migration[6.0]
  def self.up
    add_reference :subscriptions, :item, index: true, foreign_key: true
  end
  def self.down
    remove_reference :subscriptions, :item, index: true, foreign_key: true
  end
end
