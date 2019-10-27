class OodapostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :edit, :update]
  
  def show
    @oodapost = Oodapost.find(params[:id])
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
  end

  def update
  end
  
  def index
    @oodaposts = current_user.oodaposts.order(id: :desc).page(params[:page])
  end
  
  def likable
    @oodapost = Oodapost.find(params[:id])
    @likable = @oodapost.likable.page(params[:page])
    favCounts(@oodapost)
  end
  
  private

  def oodapost_params
    params.require(:oodapost).permit(:observe, :orient, :decide, :act, :title)
  end
  
  def correct_user
    @oodapost = current_user.oodaposts.find_by(id: params[:id])
    unless @oodapost
      redirect_to root_url
    end
  end
end
