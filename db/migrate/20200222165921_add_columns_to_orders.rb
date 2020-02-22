class AddColumnsToOrders < ActiveRecord::Migration[6.0]
  def self.up
    add_column :orders, :phone, :string, null: false, default: ''
    add_column :orders, :address, :string, null: false, default: ''
    add_column :orders, :apt, :string, null: false, default: ''
    add_column :orders, :city, :string, null: false, default: ''
    add_column :orders, :postal_code, :string, null: false, default: ''
    add_column :orders, :card_holder, :string, null: false, default: ''
    add_column :orders, :card_number, :string, null: false, default: ''
  end
  def self.down
    remove_column :orders, :phone
    remove_column :orders, :address
    remove_column :orders, :apt
    remove_column :orders, :city
    remove_column :orders, :postal_code
    remove_column :orders, :card_holder
    remove_column :orders, :card_number
  end
end
