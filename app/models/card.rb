class Card < ApplicationRecord
  validates :name, presence: true
  validates :number, presence: true, length: {minimum: 16, maximum: 16, message: 'should be 16 digits'}
  validates :cvv, presence: true, length: { minimum: 3, maximum: 3, message: 'is a 3-digit PIN'}
  validates :expiry_mm, inclusion: { :in => 1..13, message: '- Invalid Month'}
  validates :expiry_yy, inclusion: { :in => 1..100, message: '- Invalid Year'}
  validate :check_expiry
  belongs_to :user

  private
    def check_expiry
      unless expiry_mm.nil? or expiry_yy.nil?
        if (1...13) === expiry_mm.to_i and (1...100) === expiry_yy.to_i
          expiry_date = Date.new(2000+expiry_yy, expiry_mm, 01)
          if expiry_date.past?
            errors.add(:expiry_mm, "can't be in the past")
          end
        end
      end
    end
end
