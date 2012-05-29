class ApplicationController < ActionController::Base
  include SessionsHelper

  helper_method :current_user, :current_user?, :signed_in?, :sign_in :sign_out
end
