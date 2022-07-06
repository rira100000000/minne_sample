require 'rails_helper'


RSpec.describe UsersController, type: :controller do
  describe "#index" do
    # 未ログインのユーザーの場合
    context "as a user not to login" do
      # indexアクションのレスポンスのステータスが「302（失敗）」であることを確認
      it "returns a 302 response" do
        get :index
        expect(response).to have_http_status "302"
      end

      # indexアクションを行うとサインインページに遷移することを確認
      it "redirects to the sign-in page" do
        get :index
        expect(response).to redirect_to "/login"
      end
    end
  end
  
  describe "#new" do
    # 未ログインのユーザーの場合
    context "as a user not to login" do
      it "returns a 200 response" do
        get 'new'
        expect(response).to  be_successful
      end
      
      it "create new user" do
        get :new
        # Taskのインスタンスを生成するための情報を「task_params」に格納
        user_params = FactoryBot.attributes_for(:user)
        #「task_params」をPOSTで送信する
        post :create, params: {user: user_params }
        # レスポンスのステータスが「200」であることを確認
        expect(response).to redirect_to %r{/users/*}

      end
    end
    context "as a user logged in" do
      it "redirects to the user show" do
        user_params = FactoryBot.build(:user)
        log_in(user_params)
        remember(user_params)
        get :new
        expect(response).to redirect_to '/my_orders'
      end
    end
  end
end
