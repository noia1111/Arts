class PaintingComment < ApplicationRecord
  belongs_to :user
  belongs_to :painting
  validates :comment, presence: true, format: { with: /\S/ }
  has_many :notifications, dependent: :destroy

end
