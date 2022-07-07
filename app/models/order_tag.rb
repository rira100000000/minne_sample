class OrderTag < ApplicationRecord
  belongs_to :order
  belongs_to :tag
  validates :order_id, presence: true
  validates :tag_id, presence: true
end
