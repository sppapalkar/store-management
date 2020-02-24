class AddColumnsToRequests < ActiveRecord::Migration[6.0]
  def self.up
    add_column :requests, :status, :string, null: false, default: 'Pending'
    add_column :requests, :type, :string, null: false, default: 'S'
    add_reference :requests, :order, index: true, foreign_key: true
    add_reference :requests, :orderitem, index: true, foreign_key: true
    add_reference :requests, :user, index: true, foreign_key: true
  end
  def self.down
    remove_column :requests, :status
    remove_column :requests, :type
    remove_reference :requests, :order, index: true, foreign_key: true
    remove_reference :requests, :orderitem, index: true, foreign_key: true
    remove_reference :requests, :user, index: true, foreign_key: true
  end
end
