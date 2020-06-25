class SessionsController < ApplicationController
  before_action :require_no_user!, only: [:new, :create]

  def new
    # Render login screen
    render :new
  end

  def create
      # Find user, (pass verified in #find_by_credentials).
      user = User.find_by_credentials(
        params[:user][:username],
        params[:user][:password]
      )

      # Login user if found, redirect to try again if not
      unless user.nil?
        login!(user)
        flash[:notice] = ["Welcome back, #{ user.username }!"]
        redirect_to user_url(user)
      else
        flash[:errors] = ["Invalid Credentials, please try again. "]
        render :new
      end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

end
