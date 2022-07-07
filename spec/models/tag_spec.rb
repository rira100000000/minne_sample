require 'rails_helper'

RSpec.describe Tag, type: :model do
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
  it "is valid with a id ,name" do
    tag = Tag.new(id: 1,
                    name: 'new_tag',
                    )
    expect(tag).to be_valid
  end
  
  it "is invalid without a name" do
    tag = Tag.new(name: nil,)
    tag.valid?
    expect(tag.errors[:name]).to include("can't be blank")
  end
  
end
