class SessionsController < ApplicationController
  def new
    @title = t 'titles.session.new'
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      flash.now[:error] = t 'flash.session.error'
      @title = t 'titles.session.new'
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
