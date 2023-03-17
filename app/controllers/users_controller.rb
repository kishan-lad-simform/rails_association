class UsersController < ApplicationController
  def index
    @events = Event.where("user_id = ?", current_user.id)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    @user.create_address(address: params[:user][:address])
    if @user
      redirect_to login_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def login
    @user = User.find_by(email: params[:email])
    if @user.present? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to users_path, notice: "Login sucessfully..."
    else
      flash[:notice] = "Invalid login...."
    end
  end

  def check_login; end
  
  def logout
    session.destroy
    flash[:notice] = "You logout... :)"
    redirect_to root_path
  end

  def profile
    if current_user.present? 
      @user = User.find(current_user.id)
      @enrolled_events = current_user.events
      
    else
      redirect_to root_path
    end
  end

  private
    def user_params
      params.require(:user).permit( :name, :email, :password )
    end 

end
