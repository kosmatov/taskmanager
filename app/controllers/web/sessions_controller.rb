class Web::SessionsController < Web::ApplicationController
  def new
    title t_t :new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      flash.now[:error] = f_t :error
      title t_t :new
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
