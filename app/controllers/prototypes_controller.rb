class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  #編集・更新・削除のみこの関数を呼ぶ
  #投稿した人以外が編集したり削除したりできないようにする
  #編集と削除のアクションと更新処理ができないようにしている
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]
  #ユーザーがログインしていなかった場合、ログインページへ移る
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @prototype = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if  @prototype.save
      #レスポンスが別のlocation(場所)にリダイレクトされなければならない
      #HTTP POSTリクエストの終わりにリダイレクトが必要だ
      #Error: Form responses must redirect to another location
      #全体表示画面に戻る
      redirect_to root_path
    else
      #エラーが出る状態ならnewに戻る
      render :new,status: :unprocessable_entity
    end
  end

  def show
    #コメントが新規作成できるようにする
    @comment = Comment.new
    #複数個のコメントを取得・表示する
    #プロトタイプ(投稿)を経由するので
    @comments = @prototype.comments
  end

  def edit
  end

  def update
    #更新できたかどうかをif文で判定・更新もストロングパラメータを使用
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit,status: :unprocessable_entity
    end
  end

  def destroy
    #投稿の削除処理を実行
     if @prototype.destroy
       #全体表示画面に戻る
       redirect_to root_path
     else
       redirect_to root_path
     end
  end

  private

  def prototype_params
    #このユーザーに関連するものをフィルタリング
    #このユーザーですよ〜としていないと「誰の投稿！？」となってエラーになっていた模様
    params.require(:prototype).permit(:title, :catch_copy,:concept,:image).merge(user_id: current_user.id)
  end

  def set_prototype
    #それぞれの処理をする際に必要となる「どの投稿なのか」を取得している
    @prototype = Prototype.find(params[:id])
  end

  #投稿したユーザー以外が削除ボタンなどを押してしまってもその挙動をしないように設定
  def contributor_confirmation
    redirect_to root_path unless current_user == @prototype.user
  end
end
