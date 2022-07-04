class Suggestion < ApplicationRecord
  belongs_to :owner , class_name: 'User' ,foreign_key: :user_id
  belongs_to :order , class_name: 'Order',foreign_key: :order_id
  has_many :comments ,dependent: :destroy
  
  has_many_attached :images
  validates :user_id, presence: true
  validates :order_id, presence: true
  validates :body, presence: true, length: { maximum: 10000 }
  validates :title, presence: true, length: { maximum: 100 }
end
