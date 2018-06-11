class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_film 
  before_action :find_comment , only: [:destroy, :update, :edit]
  before_action :comment_owner, only: [:destroy, :update, :edit]
  def create
    @comment = @film.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.film_id = @film.id
    flash[:danger]= "comment not save!" unless @comment.save 
    redirect_to film_path(@film)
  end

  def destroy
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to film_path(@film)
  end

  def edit
  end

  def update
    @comment.update_attributes(comment_params)
    redirect_to @film
  end

  private
  def find_film
    redirect_to root_path unless @film = Film.find(params[:film_id])
  end

  def find_comment
    redirect_to root_path unless @comment = @film.comments.find(params[:id])
  end

  def comment_owner
    unless current_user.id == @comment.user_id
      flash[:notice] = "You can not do that"
      redirect_to @post
    end
  end
  def comment_params
    params.require(:comment).permit(:content)
  end
end
