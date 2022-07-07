class Tag < ApplicationRecord
 has_many :order_tags,dependent: :destroy, foreign_key: 'tag_id'
  # タグは複数の投稿を持つ　それは、order_tagsを通じて参照できる
  has_many :orders,through: :order_tags

  validates :name, uniqueness: true, presence: true
end
