class Hive < ApplicationRecord
  validates :name, :weight, presence: true
  validates :name, length: {minimum: 6}, uniqueness: true
  validates :weight, numericality: true
end
