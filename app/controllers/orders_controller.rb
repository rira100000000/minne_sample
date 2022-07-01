class OrdersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  def index
     @orders = Order.paginate(page: params[:page])
  end
  
  def show
    @order = Order.find(params[:id])
    @suggestion= Suggestion.new
  end
  
  def new
    logged_in_user
    @order =Order.new
  end
  
  def create
    @user = User.find(current_user.id)
    @order = @user.orders.build(order_params)
    @order.title = order_title
    @order.body = order_body
    @order.user_id = current_user.id
    
    if @order.save
      flash[:success] = "依頼を作成しました"
      redirect_to @order
    else
      flash[:danger] = "依頼作成に失敗しました"
      redirect_to request.referer
    end
  end
  
  private
    def order_title
      params.require(:order)[:title]
    end
    
    def order_body
      params.require(:order)[:body]
    end
    
    def order_params
      params.require(:order).permit(:title,:body, images: [])
    end
    
end
