class Order < ApplicationRecord
  belongs_to :owner , class_name: 'User' ,foreign_key: :user_id
  has_many :suggestions, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :body, presence: true, length: { maximum: 10000 }
  validates :title, presence: true, length: { maximum: 100 }
  has_many_attached :images
  has_many :order_tags,dependent: :destroy
  has_many :tags,through: :order_tags
  
  def save_tag(sent_tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_order_tag = Tag.find_or_create_by(name: new)
      self.tags << new_order_tag
   end
end
  
end
