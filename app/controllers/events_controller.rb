class EventsController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:index, :event_filter]

  def index
    get_category
    if session[:c_id].nil?
      @events = Event.includes(:category)
    else
      @events = Event.includes(:category).where(category_id: session[:c_id])
      session[:c_id] = nil
    end
    @events = @events.order("name desc")
  end

  def new
    @event = Event.new
    get_category
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to users_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
    get_category
  end

  def update
    @event = Event.find(params[:id]).update(event_params)
    if @event
      redirect_to users_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @events = Event.find(params[:id])
    @events.destroy
    redirect_to users_path
  end

  def event_filter
    session[:c_id] = params[:category_id]
    redirect_to events_path
  end

  def all_events
    get_all_event
  end

  def enroll
    @event = Event.find(params[:id])
    current_user.events << @event
    redirect_to all_events_path  
  end

  def show
    @comments = Comment.where(commentable_id: params[:id])            
  end

  private

  def get_category
    @categories = Category.pluck(:category_name, :id)
  end
  
  def get_all_event
    @events = Event.includes(:category)
  end

  def event_params
    params.require(:event).permit(:name, :description, :event_date, :user_id, :category_id)
  end
end
