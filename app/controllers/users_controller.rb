class UsersController < ApplicationController
  protect_from_forgery :except => [:destroy]

  def index
    @users = User.all
    @user = User.find_by(id: params[:id])
    @user_count = User.all.count
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:title, :start, :end, :alldays, :memo))
    if @user.save
      flash[:notice] = "スケジュールを新規登録しました"
      redirect_to :users
    else
      render "new", status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:title, :start, :end, :alldays, :memo))
      flash[:notice] = "「ID:#{@user.id} タイトル:#{@user.title}」の情報を更新しました"
      redirect_to :users
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "ID:#{@user.id} タイトル:#{@user.title}」の情報を削除しました"
    redirect_to :users
  end
end
