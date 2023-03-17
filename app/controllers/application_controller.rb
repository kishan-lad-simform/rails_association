class ApplicationController < ActionController::Base
  private
    def require_login
      unless current_user
        flash[:error] = 'You must be logged in to access this page.'
        redirect_to login_path
      end
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
