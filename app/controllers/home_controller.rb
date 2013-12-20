class HomeController < ApplicationController
  def index
    if current_user
      redirect_to :controller => 'simple', :action => 'display'
    end
  end

  def about
  end

  def help
  end
end
