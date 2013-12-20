class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']

    @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    if @authorization
      session[:user_id] = @authorization.user_id
      redirect_to root_url, :notice => "Signed in!"
    else
      if auth_hash["info"]["email"] == nil
        email = 'none'
      else
        email = auth_hash["info"]["email"]
      end

      if auth_hash["info"]["image"] != nil
        image = auth_hash["info"]["image"]
      else
        image = "none"
      end

      user = User.new :name => auth_hash["info"]["name"], :email => email, :image_url => image
      user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
      user.save

      session[:user_id] = user.id
      redirect_to root_url, :notice => "Signed in!"
    end
  end

  def failure
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "You have logged out!"
  end
end
