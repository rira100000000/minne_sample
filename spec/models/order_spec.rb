require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    user = User.create(id: 1,
                    name: "Aaron",
                    email: "tester@example.com",
                    password: "dottle-nouveau-pavilion-tights-furze",
                    password_confirmation: "dottle-nouveau-pavilion-tights-furze",
                    )
  end
 # user_id、title、bodyがあれば有効な状態であること
  it "is valid with a user_id,title,body" do
    order = Order.new(user_id: 1,
                    title: "test_title",
                    body: "a" *100,
                    )
    expect(order).to be_valid
  end
  
  #user_idがなければ無効な状態であること
  it "is invalid without a user_id" do
    order = Order.new(user_id: nil,
                    title: "test_title",
                    body: "a" *100,
                    )
    order.valid?
    expect(order.errors[:user_id]).to include("can't be blank") 
  end

  #titleがなければ無効な状態であること
  it "is invalid without a title" do
    order = Order.new(user_id: 1,
                    title: nil,
                    body: "a" *100,
                    )
    order.valid?
    expect(order.errors[:title]).to include("can't be blank") 
  end

  #bodyがなければ無効な状態であること
  it "is invalid without a body" do
    order = Order.new(user_id: 1,
                    title: "test_title",
                    body: nil,
                    )
    order.valid?
    expect(order.errors[:body]).to include("can't be blank") 
  end

  
end
