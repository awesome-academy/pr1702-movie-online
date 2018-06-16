class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    @top_updated_film = Film.top_updated.limit(5)
    @top_rating_film = Film.top_rate.limit(5)
    @top_view_film = Film.top_view.limit(5)
    @top_comment_film = Film.top_comment.limit(5)
  end

  def new
  end

  def search
    if params[:q][:name_or_alter_name_cont].blank?
      film_search = Film.none
    else
      film_search = @q.result
    end
    @films = film_search.paginate(page: params[:page], per_page: 12)
  end

  private
end
