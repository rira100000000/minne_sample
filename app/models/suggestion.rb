class Suggestion < ApplicationRecord
  belongs_to :user
  belongs_to :order
  has_many :comments ,dependent: :destroy
  has_many_attached :images
end
