class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # downcaseメソッドを呼び出すことで、入力したメールアドレスは全て小文字として判定
    if user && user.authenticate(params[:session][:password])
      # &&は取得したユーザーオブジェクトが有効か判定するため
      # ログイン後にユーザー情報ページにリダイレクトします。
    else
      flash.now[:danger] = "証人に失敗しました。"
      render :new
    end
  end
end