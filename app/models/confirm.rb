class Confirm < ApplicationRecord
  belongs_to :order
  belongs_to :suggestion
  has_many :messages
  validates :order_id, presence: true
  validates :suggestion_id, presence: true
end
