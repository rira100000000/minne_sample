class Order < ApplicationRecord
  belongs_to :owner , class_name: 'User' ,foreign_key: :user_id
  has_many :suggestions, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :body, presence: true, length: { maximum: 10000 }
  validates :title, presence: true, length: { maximum: 100 }
  has_many_attached :images
end
