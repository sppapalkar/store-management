class ChangeBooleanColumnsInItems < ActiveRecord::Migration[6.0]
  def change
    change_column :items, :restricted_item, :boolean, null: false, default: false
    change_column :items, :restricted_item, :boolean, null: false, default: false
  end
end
