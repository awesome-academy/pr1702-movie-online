class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_film 
  before_action :find_comment , only: [:destroy, :update, :edit]
  before_action :comment_owner, only: [:destroy, :update, :edit]
  def create
    @comment = @film.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.film_id = @film.id
    flash[:danger]= t "controllers.comments.create.comment_not_save" unless @comment.save 
    redirect_back fallback_location: root_path
  end

  def destroy
    if @comment.destroy
      flash[:success] = t "controllers.comments.destroy.delete_success"
    else
      flash[:danger] = t "controllers.comments.destroy.delete_fail"
    end
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
    @film = Film.friendly.find(params[:film_id])
    redirect_to root_path unless @film
  end

  def find_comment
    redirect_to root_path unless @comment = @film.comments.find(params[:id])
  end

  def comment_owner
    unless current_user.id == @comment.user_id
      flash[:notice] = t "controllers.comments.comment_owner.you_can_not"
      redirect_to @post
    end
  end
  def comment_params
    params.require(:comment).permit(:content)
  end
end
