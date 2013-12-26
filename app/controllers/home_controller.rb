class HomeController < ApplicationController
  def index
    if current_user
      redirect_to :controller => 'board', :action => 'show'
    end
  end

  def about
  end

  def help
  end
end
