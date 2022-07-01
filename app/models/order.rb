class Order < ApplicationRecord
  belongs_to :user
  has_many :suggestions, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :body, presence: true, length: { maximum: 10000 }
  has_many_attached :images
end
