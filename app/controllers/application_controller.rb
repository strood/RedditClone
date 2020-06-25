class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login!(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def logout!
    current_user.try(:reset_session_token)
    session['session_token'] = nil
  end

  def require_current_user!
    redirect_to new_session_url if current_user.nil?
  end

  def require_no_user!
    redirect_to user_url(current_user) if current_user
  end

  def require_owning_user!
    flash[:error] = ['Only able to view your own account page']
    redirect_to user_url(current_user) if current_user.id != params[:id].to_i
  end
end
