class ApplicationController < ActionController::Base
  include SessionsHelper
  include ApplicationHelper
  protect_from_forgery
  # 記憶したURL（もしくはデフォルト値）にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
  
  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  
    # ログイン済みユーザーかどうか確認
  def not_logged_in_user
    if logged_in?
      flash[:danger] = "you are already logged in."
      redirect_to '/my_orders'
    end
  end

  
  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
  helper_method :logged_in_user
  
  def display_image(image)
    image.variant(resize_to_limit: [150, 150])
  end
  
  helper_method :display_image
end
