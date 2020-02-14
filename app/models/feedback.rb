class Feedback < ApplicationRecord
  validates :name, presence :true
  belongs_to :name
end
