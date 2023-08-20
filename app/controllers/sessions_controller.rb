class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # downcaseメソッドを呼び出すことで、入力したメールアドレスは全て小文字として判定
    if user && user.authenticate(params[:session][:password])
      # &&は取得したユーザーオブジェクトが有効か判定するため
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = "証人に失敗しました。"
      render :new
    end
  end
  
  def destroy
    # ログイン中の場合のみログアウト処理を実行します
    log_out if logged_in?
    flash[:success] = "ログアウトしました"
    redirect_to root_url
  end
end