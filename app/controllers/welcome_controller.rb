class WelcomeController < ApplicationController
  def index
    @title = t 'titles.welcome.index'
  end
end
