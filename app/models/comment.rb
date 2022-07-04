class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :suggestion
  has_many_attached :images
  validates :user_id, presence: true
  validates :suggestion_id, presence: true
  validates :content, presence: true, length: { maximum: 10000 }
end
