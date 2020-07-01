class ApplicationController < ActionController::Base
  helper_method :current_user
  protect_from_forgery with: :exception


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

  def require_user_is_user!
    # TODO: Will likely change this to allow admins, and maybe more
    flash[:error] = ['Only able to view your own account page']
    redirect_to user_url(current_user) if current_user.id != params[:id].to_i
  end

  def require_user_owns_post!
    flash[:error] = ['Only able to edit your own post!']
    redirect_to user_url(current_user) if current_user != Post.find(params[:id]).author
  end


  def require_user_owns_sub!
    flash[:error] = ['Only able to edit your own sub!']
    redirect_to user_url(current_user) if current_user != Sub.find(params[:id]).moderator
  end

  def require_user_owns_comment! #Not used atm
    flash[:error] = ['Only able to edit your own comments!']
    redirect_to user_url(current_user) if current_user != Comment.find(params[:id]).author

  end
end
