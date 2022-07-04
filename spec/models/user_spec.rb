require 'rails_helper'

RSpec.describe User, type: :model do
  
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  
  # 姓、名、メール、パスワードがあれば有効な状態であること
  it "is valid with a first name, last name, email, and password" do
    user = User.new(name: "Aaron",
                    email: "tester@example.com",
                    password: "dottle-nouveau-pavilion-tights-furze",
                    password_confirmation: "dottle-nouveau-pavilion-tights-furze",
                    )
    expect(user).to be_valid
  end
  
  # 名がなければ無効な状態であること
  it "is invalid without a first name" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end
  
  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    user =User.new( name: "Joe",
             email: nil,
             password: "dottle-nouveau-pavilion-tights-furze",
             password_confirmation: "dottle-nouveau-pavilion-tights-furze",
             )
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  #メールアドレスの重複が無効な状態であること
  it "is invalid with a duplicate email address" do
    User.create( name: "Joe",
                 email: "tester@example.com",
                 password: "dottle-nouveau-pavilion-tights-furze",
                 password_confirmation: "dottle-nouveau-pavilion-tights-furze",
                 )
    user = User.new(name: "Jane",
                    email: "tester@example.com",
                    password: "dottle-nouveau-pavilion-tights-furze",
                    password_confirmation: "dottle-nouveau-pavilion-tights-furze",
                    )
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
  
  it "is invalid with a password length underto 6" do
    user = User.new(name: "Jane",
                    email: "tester@example.com",
                    password: "12345",
                    password_confirmation: "12345",
                    )
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end
  
  it "is invalid with a profile length upto 300" do
    user = User.new(name: "Jane",
                    email: "tester@example.com",
                    password: "123456",
                    password_confirmation: "123456",
                    profile: 'a'*301 ,
                    )
    user.valid?
    expect(user.errors[:profile]).to include("is too long (maximum is 300 characters)")
  end
end
