class AddColumnsToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :brand, :string, null: false, default: ''
    add_column :items, :category_id, :integer
    change_column :items, :category_id, :integer, null: false, default: ''
    add_foreign_key :items, :categories
    add_column :items, :restricted_item, :boolean
    change_column :items, :restricted_item, :integer, null: false, default: ''
    add_column :items, :age_restricted_item, :boolean
    change_column :items, :age_restricted_item, :integer, null: false, default: ''
    add_column :items, :quantity, :integer
    change_column :items, :quantity, :integer, null: false, default: ''
  end
end
