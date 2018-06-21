class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    @top_updated_film = Film.top_updated.limit(Settings.static_page.top_movie)
    @top_rating_film = Film.top_rate.limit(Settings.static_page.top_movie)
    @top_view_film = Film.top_view.limit(Settings.static_page.top_movie)
    @top_comment_film = Film.top_comment.limit(Settings.static_page.top_movie)
  end

  def new
  end

  def search
    if params[:q][:name_or_alter_name_cont].blank?
      film_search = Film.none
    else
      film_search = @q.result
    end
    @films = film_search.paginate(page: params[:page], per_page: Settings.film.per_page)
  end

  private
end
