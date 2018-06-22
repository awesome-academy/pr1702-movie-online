class FilmsController < ApplicationController
  skip_before_action :authenticate_user!

  def index; end

  def filter
    filter_films = Film.all
    filter_params.each do |key, val|
      filter_films.merge!(filter_films.send(key, val)) if (Film.respond_to? key) && (val.present?)
    end
    @category = [["Movie", "1"], ["TV_series", "2"]]
    @selected_params = filter_params
    @films = filter_films.paginate(page: params[:page],
                                    per_page: Settings.film.per_page)
  end

  def top_movie
    @top_movies = Film.top_movie_by(params[:type]).paginate(page: params[:page], per_page: Settings.film.per_page)
  end

  def show
    @film = Film.friendly.find_by slug: params[:id]
    redirect_to root_url unless @film
    @avg_rating = @film.rate_cal
    @comments = @film.comments.sort_comments.paginate(page: params[:page], per_page: Settings.film.per_page)
  end

  def view
    @film = Film.friendly.find_by slug: params[:id]
    redirect_to root_url unless @film
    @episodes = @film.episodes.sort_episodes
    @episode = params[:episode_id] ? @episodes.find_by(id: params[:episode_id]) : @episodes.first
    if @episode.link_exist?
      @quality = @episode.link_episodes.last.quality unless params[:quality]
    end
    redirect_to view_film_path(@film) unless @episodes.include? @episode
    @comments = @film.comments.sort_comments.paginate(page: params[:page], per_page: Settings.film.per_page)
  end

  private
  def filter_params
    params.permit(:origin, :genre, :category)
  end

end
