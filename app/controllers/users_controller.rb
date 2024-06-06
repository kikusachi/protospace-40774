class UsersController < ApplicationController
  def show
    #表示させるユーザーの情報を取得
    @user = User.find(params[:id])
  end
end
