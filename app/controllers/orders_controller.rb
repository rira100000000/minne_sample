class OrdersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy,:my_orders]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  def index
    @orders = Order.paginate(page: params[:page])
    @tag_list=Tag.all
  end
  
  def show
    @order = Order.find(params[:id])
    @suggestion= Suggestion.new
    @tag_list = @order.tags

  end
  
  def new
    logged_in_user
    @order =Order.new
    @tag_list=@order.tags.pluck(:name).join(',')
  end
  
  def create
    @user = User.find(current_user.id)
    @order = @user.orders.build(order_params)
    @order.title = order_title
    @order.body = order_body
    @order.user_id = current_user.id
    tag_list=params[:order][:name].split(',')
    
    if @order.save
      @order.save_tag(tag_list)
      flash[:success] = "依頼を作成しました"
      redirect_to @order
    else
      flash[:danger] = "依頼作成に失敗しました"
      redirect_to request.referer
    end
  end
  
  def my_orders
    @user = User.find(current_user.id)
    @orders = @user.orders.paginate(page: params[:page])
    @recieved_orders = Order.where reciever: @user.id
    @suggestions = Suggestion.where user_id: @user.id
    @avatar = @user.avatar
    @profile = @user.profile
    
    #提案中の依頼から既に受注済み依頼を除く処理
    order_ids =[]
    @recieved_orders.each do |ordar|
      order_ids << ordar.id
    end
    
    suggestion_order_ids =[]
    @suggestions.each do |suggestion|
      suggestion_order_ids << suggestion.order_id if !order_ids.include?(suggestion.order_id)
    end
    
    @suggestion_orders = Order.where id: suggestion_order_ids
    @my_orders = Order.where user_id: @user.id

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
