class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  def create
    oodapost = Oodapost.find(params[:oodapost_id])
    current_user.favorite(oodapost)
    flash[:success] = 'お気に入りに登録しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    oodapost = Oodapost.find(params[:oodapost_id])
    current_user.unfavorite(oodapost)
    flash[:success] = 'お気に入りから削除しました。'
    redirect_back(fallback_location: root_path)
  end
end
