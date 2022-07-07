require 'rails_helper'

RSpec.describe OrderTag, type: :model do
  before do
    user = User.create(id: 1,
                    name: "Aaron",
                    email: "tester@example.com",
                    password: "dottle-nouveau-pavilion-tights-furze",
                    password_confirmation: "dottle-nouveau-pavilion-tights-furze",
                    )
    order = Order.create(id: 1,
                    user_id: 1,
                    title: "test_title",
                    body: "a" *100,
                    )
    tag = Tag.create(id: 1,
                    name: 'tag')
  end
  it "is valid with a order_id, tag_id" do
    order_tag = OrderTag.new(order_id: 1,
                    tag_id: 1,
                    )
    expect(order_tag).to be_valid
  end
  
  it "is invalid without a order_id" do
    order_tag = OrderTag.new(order_id: nil,
                    tag_id: 1,
                    )
    order_tag.valid?
    expect(order_tag.errors[:order_id]).to include("can't be blank")
  end
  
  it "is invalid without a tag_id" do
    order_tag = OrderTag.new(order_id: 1,
                    tag_id: nil,
                    )
    order_tag.valid?
    expect(order_tag.errors[:tag_id]).to include("can't be blank")
  end
    
end
