class Hero < ApplicationRecord
  def sum_greater_than_300
     if atk + hp + defense + hp > 300
       errors.add(:base, 'Your stats cannot add to a number greater than 300')
     end
  end

  belongs_to :user
  validates :name, presence: true
  validates :kind, presence: true
  validates :hp, presence: true
  validates :defense, presence: true
  validates :atk, presence: true
  validates :speed, presence: true
  validates :hp, numericality: true
  validates :defense, numericality: true
  validates :atk, numericality: true
  validates :speed, numericality: true

  validate :sum_greater_than_300
end
