require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @order = @user.orders.build(title: 'test',body: "Lorem ipsum")

  end

  test "should be valid" do
    assert @order.valid?
  end

  test "user id should be present" do
    @order.user_id = nil
    assert_not @order.valid?
  end
  
  test "body should be present" do
    @order.body = "   "
    assert_not @order.valid?
  end

  test "body should be at most 10000 characters" do
    @order.body = "a" * 10001
    assert_not @order.valid?
  end
  
  test "order should be most recent first" do
    assert_equal orders(:most_recent), Order.first
  end
  
end
