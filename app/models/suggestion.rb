class Suggestion < ApplicationRecord
  belongs_to :user
  belongs_to :order
  has_many :comments ,dependent: :destroy
  has_many_attached :images
  validates :user_id, presence: true
  validates :order_id, presence: true
  validates :body, presence: true, length: { maximum: 10000 }
  validates :title, presence: true, length: { maximum: 100 }
end
