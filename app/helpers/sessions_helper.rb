module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  #remember user in a persistent session
  def remember(user)
    user.remember
    cookies.signed[:user_id] = { value: user.id,
                                 expires: 7.days.from_now.utc}
    cookies[:remember_token] = { value: user.remember_token,
                                 expires: 7.days.from_now.utc}
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def current_user?(user)
    user == current_user
  end

  #return true if user is logged in
  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  #store url trying t be accessed
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end



end
