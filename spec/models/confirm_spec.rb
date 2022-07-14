require 'rails_helper'
RSpec.describe Confirm, type: :model do
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
                    user_id: 2,
                    order_id: 1,
                    title: "test_title",
                    body: "a" *100,
                    price: 1000,
                    deadline: 10
                    )
  end
  
 # order_id,suggestion_idがあれば有効な状態であること
  it "is valid with a order_id,suggestion_id" do
    confirm = Confirm.new(
      order_id: 1,
      suggestion_id: 1
      )
    expect(confirm).to be_valid
  end
end
