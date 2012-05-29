class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(21)
    @title = t 'titles.user.index'
  end

  def new
    @user = User.new
    @title = t 'titles.user.new'
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, notify: t('flash.user.welcome')
    else
      @title = t 'titles.user.new'
      render :new
    end
  end

  def edit
    @user = current_user
    @title = t 'titles.user.edit'
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: t('flash.user.updated')
    else
      @title = t 'titles.user.edit'
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    if current_user?(user)
      flash[:error] = t 'flash.user.error_destroy_self'
    else
      user.destroy
      flash[:success] = t 'flash.user.destroyed'
    end
    redirect_to users_path
  end
end
