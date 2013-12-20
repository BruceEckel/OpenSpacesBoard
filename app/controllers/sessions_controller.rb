class SessionsController < ApplicationController
  def new
  end

  # Check authorizations and create a new user if none are found, otherwise, log the user in based on their
  # existing authorization
  def create
    # Grab an authorizatio token from the provider selected
    auth_hash = request.env['omniauth.auth']

    # Check if there is an auth token stored that matches the returned token
    # If there is a match, the user alread exists, if not, they need to be created
    @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    if @authorization
      # Create the user session object
      session[:user_id] = @authorization.user_id
      redirect_to root_url, :notice => "Signed in!"
    else
      # Create a new user

      # Check if the auth token contains an email address, and set accordingly
      # Not all providers return email
      if auth_hash["info"]["email"] == nil
        email = 'none'
      else
        email = auth_hash["info"]["email"]
      end

      # Check if the auth token has an image url for the user, and set accordingly
      # Not all providers return this information
      if auth_hash["info"]["image"] != nil
        image = auth_hash["info"]["image"]
      else
        image = "none"
      end

      # Create the new user, adding the authorization information to the database for later user
      user = User.new :name => auth_hash["info"]["name"], :email => email, :image_url => image
      user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
      user.save

      # Create the user session object
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Signed in!"
    end
  end

  def failure
  end

  # Destroy the user session object, logging the user out
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "You have logged out!"
  end
end
