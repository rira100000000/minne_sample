require 'rails_helper'

RSpec.describe Suggestion, type: :model do
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
  end
  
   # user_id、order_id,title、body,price,deadlineがあれば有効な状態であること
  it "is valid with a user_id,order_id,title,body,price,deadline" do
    suggestion = Suggestion.new(user_id: 1,
                    order_id: 1,
                    title: "test_title",
                    body: "a" *100,
                    price: 1000,
                    deadline: 10
                    )
    expect(suggestion).to be_valid
  end
  
  #user_idがなければ無効な状態であること
  it "is invalid without a user_id" do
    suggestion = Suggestion.new(user_id: nil,
                    order_id: 1,
                    title: "test_title",
                    body: "a" *100,
                    price: 1000,
                    deadline: 10
                    )
    suggestion.valid?
    expect(suggestion.errors[:user_id]).to include("can't be blank") 
  end
  
  #order_idがなければ無効な状態であること
  it "is invalid without a order_id" do
    suggestion = Suggestion.new(user_id: 1,
                    order_id: nil,
                    title: "test_title",
                    body: "a" *100,
                    price: 1000,
                    deadline: 10
                    )
    suggestion.valid?
    expect(suggestion.errors[:order_id]).to include("can't be blank") 
  end
  
 #titleがなければ無効な状態であること
  it "is invalid without a title" do
    suggestion = Suggestion.new(user_id: 1,
                    order_id: 1,
                    title: nil ,
                    body: "a" *100,
                    price: 1000,
                    deadline: 10
                    )
    suggestion.valid?
    expect(suggestion.errors[:title]).to include("can't be blank") 
  end
  
   #bodyがなければ無効な状態であること
  it "is invalid without a body" do
    suggestion = Suggestion.new(user_id: 1,
                    order_id: 1,
                    title: "test_title",
                    body: nil,
                    price: 1000,
                    deadline: 10
                    )
    suggestion.valid?
    expect(suggestion.errors[:body]).to include("can't be blank") 
  end
  
     #priceがなければ無効な状態であること
  it "is invalid without a price" do
    suggestion = Suggestion.new(user_id: 1,
                    order_id: 1,
                    title: "test_title",
                    body: "test_body",
                    price: nil,
                    deadline: 10
                    )
    suggestion.valid?
    expect(suggestion.errors[:price]).to include("can't be blank") 
  end
  
     #bodyがなければ無効な状態であること
  it "is invalid without a deadline" do
    suggestion = Suggestion.new(user_id: 1,
                    order_id: 1,
                    title: "test_title",
                    body: nil,
                    price: 1000,
                    deadline: nil
                    )
    suggestion.valid?
    expect(suggestion.errors[:deadline]).to include("can't be blank") 
  end

  
end
