class Web::UsersController < Web::ApplicationController
  def index
    @users = User.page(params[:page])
    title t_t :index
  end

  def new
    @user = User.new
    title t_t :new
  end

  def show
    @user = User.find(params[:id])
    title @user.name
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = f_t :welcome
      redirect_to @user
    else
      title t_t :new
      render :new
    end
  end

  def edit
    @user = current_user
    title t_t :edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = f_t :updated
      redirect_to @user
    else
      title t_t :edit
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    if current_user?(user)
      flash[:error] = f_t :error_destroy_self
    else
      user.destroy
      flash[:success] = f_t :destroyed
    end
    redirect_to users_path
  end
end
