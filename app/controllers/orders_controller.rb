class OrdersController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit, :update, :destroy,:my_orders]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :pending_order,  only: [:edit , :update,:destroy]
  
  protect_from_forgery :except => [:destroy]
  
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
  
  def edit
    @order = Order.find(params[:id])
    @tag_list=@order.tags.pluck(:name).join(',')
    @user = User.find(@order.user_id)
  end
  
  def update
     @order = Order.find(params[:id])
    if @order.update(order_params)
      tag_list=params[:order][:name].split(',')
      @order.save_tag(tag_list)
      flash[:success] = "オーダーを更新しました"
      redirect_to @order
    else
      flash[:danger] = "オーダー更新に失敗しました"
      render 'edit'
    end
  end
  
  def destroy
    Order.find(params[:id]).destroy
    flash[:success] = "オーダーを削除しました"
    redirect_to '/my_orders'
  end
  
  def my_orders
    @user = User.find(current_user.id)
    suggestions = Suggestion.where user_id: @user.id
    @avatar = @user.avatar
    @profile = @user.profile
    
    #提案した依頼全て
    suggested_orders = suggestions.map{|suggestion|Order.find suggestion.order_id}
    #受注済み依頼
    @confirmed_orders = suggested_orders.inject([]) do |arr,ordar|
      next arr unless ordar.status=='confirmed'
      arr.push(ordar)
    end

    #現在提案中依頼
    @pending_orders = suggested_orders.inject([]) do |arr,ordar|
      next arr unless ordar.status=='pending'
      arr.push(ordar)
    end
    
    #自分の出したオーダーすべて
    @my_orders = Order.where user_id: @user.id
    
    #自分の出した依頼（発注済み)
    @my_confirmed_orders = @my_orders.inject([]) do |arr,my_order|
      next arr unless my_order.status == 'confirmed'
      arr.push(my_order)
    end
    #自分の出した依頼（未発注)
    @my_unconfirmed_orders = @my_orders.inject([]) do|arr,my_order|
      next arr unless my_order.status == 'pending'
      arr.push(my_order)
    end
  end
  
  def uploaded_images
    params[:order][:images].map{|id| ActiveStorage::Blob.find(id)} if params[:order][:images]
  end

  
  
  private
    def order_title
      params.require(:order)[:title]
    end
    
    def order_body
      params.require(:order)[:body]
    end
    
    def order_params
    params.require(:order).permit(:title,:body,:image).merge(images: uploaded_images)
    end
  
    
    def pending_order
      @order = Order.find(params[:id])
      unless @order.status =='pending'
        flash[:danger] = "このオーダーは編集できません"
        redirect_to '/my_orders'
      end
    end

    
end
