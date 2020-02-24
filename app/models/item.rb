class Item < ApplicationRecord
  validates :name, presence: true
  belongs_to :category

  def get_name
    "#{brand} #{name}"
  end
end
