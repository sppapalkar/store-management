class AddColumnToOrderitems < ActiveRecord::Migration[6.0]
  def self.up
    add_column :orderitems, :brand, :string, null: false, default: ''
    add_column :orderitems, :name, :string, null: false, default: ''
    add_column :orderitems, :price, :decimal, null: false, default: 0.0
    add_column :orderitems, :status, :string, null: false, default: 'Complete'
  end
  def self.down
    remove_column :orderitems, :brand
    remove_column :orderitems, :name
    remove_column :orderitems, :price
    remove_column :orderitems, :status
  end
end
