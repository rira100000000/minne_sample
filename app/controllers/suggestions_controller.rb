class SuggestionsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create,:edit, :update, :destroy]
  def show
    @suggestion = Suggestion.find(params[:id])
    @order = Order.find(@suggestion.order_id)
    @user = User.find(@order.user_id)
    @comment = Comment.new
  end
  
  def create
    @order = Order.find(suggestion_order_id)
    @suggestion =@order.suggestions.build(suggestion_params)
    
    @suggestion.title = suggestion_title
    @suggestion.body =  suggestion_body
    @suggestion.order_id = suggestion_order_id
    @suggestion.user_id= current_user.id

    if @suggestion.save
     flash[:success] = "提案を送信しました"
      redirect_to @suggestion
    else
      flash[:danger] = "提案送信に失敗しました"
      redirect_to request.referer
    end
  end
  
  def edit
    @suggestion = Suggestion.find(params[:id])
    @order = Order.find(@suggestion.order_id)

  end
  
  def update
    @suggestion = Suggestion.find(params[:id])
    if @suggestion.update(suggestion_params)
      flash[:success] = "提案を更新しました"
      redirect_to @suggestion
    else
      flash[:danger] = "提案更新に失敗しました"
      render 'edit'
    end
  end
  
  def uploaded_images
    if !params[:order].nil? && params[:order][:images]
      params[:order][:images].map{|id| ActiveStorage::Blob.find(id)} 
    end
  end

  
  private
    
    def suggestion_params
    params.require(:suggestion).permit(:title,:body,:order_id,:image).merge(images: uploaded_images)
    end
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
