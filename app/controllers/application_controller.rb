class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :avatar_url

  private

  # Returns the current user (if there is one), as defined by the user session object
  # This session object is created when a user logs in via OAuth
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Get the url for the currently logged in users gravatar image (if they have one)
  # Some providers (Github) provide an image URL, which is stored upon user creation. If a url is present on the
  # user, use that, otherwise, generate a gravatar url from the user email
  def avatar_url(user)
    if (user.image_url == 'none')
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
    else
      user.image_url
    end
  end
end
