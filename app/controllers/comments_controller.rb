class CommentsController < ApplicationController
  def create
    #コメントの新規作成
    @comment = Comment.new(comment_params)
    #コメントを保存
    if @comment.save
      #コメントを現在見ている投稿に付与する
      redirect_to prototype_path(@comment.prototype)
    else
      #保存に失敗したらコメントを投稿しようとした投稿への参照を入れる
      #prototypes/showで詳細画面でコメントを表示させるようにするため
      @prototype = @comment.prototype
      #投稿へのコメントを全て表示させる
      @comments = @prototype.comments
      #詳細ページへ
      render "prototypes/show"
    end
  end

  private
  #コメントの作成・コメントデータベースにコメントを追加・ユーザーidと投稿
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id,prototype_id: params[:prototype_id])
  end
end
