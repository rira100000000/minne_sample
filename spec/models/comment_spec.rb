require 'rails_helper'

RSpec.describe Comment, type: :model do
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
    suggestion = Suggestion.create(id: 1,
                    order_id: 1,
                    user_id: 1,
                    title: "test_title",
                    body: "a" *100,
                    price: 1000 ,
                    deadline: 10,
                    )
  end
  
   # user_id、suggestion_id,bodyがあれば有効な状態であること
  it "is valid with a user_id, suggestion_id, body" do
    comment = Comment.new(user_id: 1,
                    suggestion_id: 1,
                    content: "a" *100,
                    )
    expect(comment).to be_valid
  end
  
  it "is invalid without a user_id" do
    comment = Comment.new(user_id: nil,
                    suggestion_id: 1,
                    content: "a" *100,
                    )
    comment.valid?
    expect(comment.errors[:user_id]).to include("can't be blank") 
  end

  it "is invalid without a suggestion_id" do
    comment = Comment.new(user_id: 1,
                    suggestion_id: nil,
                    content: "a" *100,
                    )
    comment.valid?
    expect(comment.errors[:suggestion_id]).to include("can't be blank") 
  end

  it "is invalid without a conten" do
    comment = Comment.new(user_id: 1,
                    suggestion_id: 1,
                    content: nil,
                    )
    comment.valid?
    expect(comment.errors[:content]).to include("can't be blank") 
  end

  
end
