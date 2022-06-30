class SuggestionsController < ApplicationController
  def show
    @suggestion = Suggestion.find(params[:id])
    @order = Order.find(@suggestion.order_id)
    @user = User.find(@order.user_id)
  end
end
