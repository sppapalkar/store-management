class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false, default: ''
    add_column :users, :phone,:string, null: false, default: ''
    add_column :users, :dob,:date
    add_column :users, :address, :string, null: false, default: ''
    add_column :users, :apt, :string, null: false, default: ''
    add_column :users, :city, :string, null: false, default: ''
    add_column :users, :postal_code, :string, null: false, default: ''
  end
end
