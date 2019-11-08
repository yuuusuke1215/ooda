class OodapostsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :destroy, :update, :edit, :likable]
  before_action :correct_user, only: [:destroy, :edit, :update]
  
  def show
    @oodapost = Oodapost.find(params[:id])
    @comments = @oodapost.comments
    @comment = Comment.new
  end

  def new
    @oodapost = Oodapost.new
  end

  def create
    @oodapost = current_user.oodaposts.build(oodapost_params)
    
    if @oodapost.save
      flash[:success] = '無事に投稿できました。'
      redirect_to root_url
    else
      flash.now[:danger] = '投稿に失敗しました。'
      render :new
    end
  end

  def destroy
    @oodapost.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_to root_url
  end

  def edit
    @oodapost = Oodapost.find(params[:id])
  end

  def update
    @oodapost = Oodapost.find(params[:id])
    
    if @oodapost.update(oodapost_params)
      flash[:success] = '記事を更新しました。'
      redirect_to @oodapost
    else
      flash.now[:danger] = '記事を更新できませんでした。'
      render :edit
    end
  end
  
  def index
    @oodaposts = Oodapost.all.order(id: :desc).page(params[:page])
    
    @q = Oodapost.ransack(params[:q])
    @search_oodaposts = @q.result(distinct: true)
  end
  
  def likable
    @oodapost = Oodapost.find(params[:id])
    @likable = @oodapost.likable.page(params[:page])
    favCounts(@oodapost)
  end
  
  def search
    @oodaposts = Oodapost.search(params[:search])
  end
  
  private

  def oodapost_params
    params.require(:oodapost).permit(:observe, :orient, :decide, :act, :title, :image, :tag)
  end
  
  def correct_user
    @oodapost = current_user.oodaposts.find_by(id: params[:id])
    unless @oodapost
      redirect_to root_url
    end
  end
end
