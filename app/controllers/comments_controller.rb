class CommentsController < ApplicationController
  before_action :require_login

  def add_comment
    @comments = Comment.new
  end

  def create_comment
    event_id = params[:id]
    @event = Event.find(event_id)
    @event.create_comment(comment: params[:comment][:comment])
    redirect_to users_path
  end

  def like_comment
    @like = Like
      .create(user_id: current_user.id,
              comment_id: params[:id])
    redirect_to users_path
  end

  def show_like
    @likes = Like
      .includes(:comment)
      .where(user_id: current_user.id)
  end

  def dislike_comment
    @like = Like.find( params[:id] )
    @like.destroy
    redirect_to show_like_path
  end

end
