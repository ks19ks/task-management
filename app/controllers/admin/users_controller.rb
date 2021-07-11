class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :set_user, only: %i(show edit update destroy)

  def index
    @users = User.includes(:tasks).order('created_at DESC')
  end

  def show
    @tasks = Task.where(user_id: @user.id)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user), notice: "ユーザー #{@user.name} を登録しました"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー #{@user.name} を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザー #{@user.name} を削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_admin
    redirect_to tasks_path, notice: '管理者以外はアクセスできません' unless current_user.admin?
  end
end
