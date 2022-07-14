class Message < ApplicationRecord
  belongs_to :user
  belongs_to :confirm
  has_many_attached :images
  validates :user_id, presence: true
  validates :confirm_id, presence: true
  validates :body, presence: true, length: { maximum: 10000 }
end
