require 'rails_helper'

RSpec.describe Message, type: :model do
 before do
    user = User.create(id: 1,
                      name: "Aaron",
                      email: "tester@example.com",
                      password: "dottle-nouveau-pavilion-tights-furze",
                      password_confirmation: "dottle-nouveau-pavilion-tights-furze",
                      )
                      
    user = User.create(id: 2,
                      name: "ron",
                      email: "tester2@example.com",
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
                                  user_id: 2,
                                  title: "test_title",
                                  body: "a" *100,
                                  price: 1000 ,
                                  deadline: 10,
                                  )
    confirm = Confirm.create(id:1,
                            order_id: 1,
                            suggestion_id: 1)
  end
  
   # user_id、suggestion_id,bodyがあれば有効な状態であること
  it "is valid with a confirm_id, user_id, body" do
    message = Message.new(confirm_id: 1,
                    user_id: 1,
                    body: "a" *100,
                    )
    expect(message).to be_valid
  end
  
  it "is invalid without a user_id" do
    message = Message.new(confirm_id: 1,
                    user_id: nil,
                    body: "a" *100,
                    )
    message.valid?
    expect(message.errors[:user_id]).to include("can't be blank") 
  end

  it "is invalid without a confirm_id" do
    message = Message.new(confirm_id: nil,
                    user_id: 1,
                    body: "a" *100,
                    )
    message.valid?
    expect(message.errors[:confirm_id]).to include("can't be blank") 
  end

  it "is invalid without a body" do
    message = Message.new(user_id: 1,
                    confirm_id: 1,
                    body: nil,
                    )
    message.valid?
    expect(message.errors[:body]).to include("can't be blank") 
  end

  
end
