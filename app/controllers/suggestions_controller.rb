class SuggestionsController < ApplicationController
  def show
    @suggestion = Suggestion.find(params[:id])
    @order = Order.find(@suggestion.order_id)
    @user = User.find(@order.user_id)
    @comment = Comment.new
  end
  
  def create
    @order = Order.find(suggestion_order_id)
    @suggestion =@order.suggestions.build(title: suggestion_title,
                      body: suggestion_body,
                      order_id: suggestion_order_id,
                      user_id: current_user.id)
    if @suggestion.save
     flash[:success] = "提案を送信しました"
      redirect_to request.referer
    else
      flash[:danger] = "提案送信に失敗しました"
      redirect_to request.referer
    end
  end
  
  private
  
    def suggestion_title
      params.require(:suggestion)[:title]
    end
    def suggestion_body
      params.require(:suggestion)[:body]
    end
    def suggestion_order_id
       params.require(:suggestion)[:order_id]
    end
end
