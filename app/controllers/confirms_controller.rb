class ConfirmsController < ApplicationController
  def create
    @confirm = Confirm.new(confirm_params)
    @order=Order.find(@confirm.order_id)
    @order.status = :confirmed
    @user = User.find(@order.user_id)
    if @order.save
      @confirm.receiver_name = @user.receiver_name
      @confirm.postcode = @user.postcode
      @confirm.address = @user.address
      @confirm.tel = @user.tel
      if @confirm.save
        flash[:success] = "オーダーが確定しました"
        redirect_to @confirm
      else
        @order.status = :pending
        if @order.save
          flash[:danger] = "オーダー確定に失敗しました。エラーコード002"
        else
          flash[:danger] = "オーダー確定に失敗しました。エラーコード003"
        end
        redirect_to request.referer
      end
    else
    flash[:danger] = "オーダー確定に失敗しました。エラーコード001"
    redirect_to request.referer
    end
  end

  def show
    @confirm = Confirm.find(params[:id])
    @order = Order.find(@confirm.order_id)
    if current_user?(User.find(@order.user_id))
      @suggestion = Suggestion.find(@confirm.suggestion_id)
      @message =Message.new
    else
      redirect_to my_orders_url
    end
  end

  def detail
    @confirm = Confirm.find(params[:id])
    @suggestion = Suggestion.find(@confirm.suggestion_id)
    if current_user?(User.find(@suggestion.user_id))
      @order = Order.find(@confirm.order_id)
      @message =Message.new
    else
      redirect_to my_orders_url
    end
  end
  
  def update
    @confirm = Confirm.find(params[:id])
    if @confirm.update(address_params)
      flash[:success] = "発送先情報を更新しました"
      redirect_to @confirm
    else
      flash[:danger] = "発送先情報の更新に失敗しました"
      render 'edit'
    end

  end

  def destroy
  end
  
private
  def confirm_params
    params.require(:confirm).permit(:order_id,:suggestion_id)
  end 
  
  def address_params
    params.require(:confirm).permit(:receiver_name,:postcode,:address,:tel)
  end
end
