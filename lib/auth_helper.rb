module AuthHelper
  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def current_user?(user)
    current_user == user
  end
  
  def signed_in?
    session[:user_id] && current_user
  end
  
  def sign_in(user)
    session[:user_id] = user
  end

  def sign_out
    session[:user_id] = nil
  end
end
