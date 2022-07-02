class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @orders = @user.orders.paginate(page: params[:page])
    @recieved_orders = Order.where reciever: @user.id
    @suggestions = Suggestion.where user_id: @user.id
    @image = @user.image
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

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @image = @user.image
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation,
                                   :image, :profile)
    end
    
end
