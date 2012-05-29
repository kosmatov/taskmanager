class Web::ApplicationController < ApplicationController
  include AuthHelper
  include FlashHelper
  include TitlesHelper

  helper_method :title, :sign_in, :sign_out, :signed_in?, :current_user, :current_user?
  
  private

  def title(part = nil)
    @parts ||= []
    unless part
      return nil if @parts.blank?
      return @parts.reverse.join(' - ')
    end
    @parts << part
  end
end
