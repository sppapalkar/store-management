class Card < ApplicationRecord
  validates :name, :number, :cvv, :expiry_mm, :expiry_yy, presence: true
  belongs_to :user
end
