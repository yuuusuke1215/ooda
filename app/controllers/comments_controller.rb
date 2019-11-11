class CommentsController < ApplicationController
  before_action :require_user_logged_in
  def create
    @oodapost = Oodapost.find(params[:oodapost_id])
    @comment = @oodapost.comments.build(comment_params)
    @comment.user = current_user
    
    if @comment.save
      @oodapost.create_notification_comment!(current_user, @comment.id)
      flash[:success] = '無事にコメントできました。'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = 'コメントに失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
