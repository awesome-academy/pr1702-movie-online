class Film < ApplicationRecord
  ratyrate_rateable :rate
  has_many :episodes

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :film_genres
  has_many :genres, through: :film_genres

  has_many :film_origins
  has_many :origins, through: :film_origins

  has_many :comments

  scope :movie, -> { where("num_ep = 1") }
  scope :tv_series, -> { where("num_ep > 1") }

  scope :category, -> (category) {
    case category
    when Settings.film.movie
      movie
    when Settings.film.tv_series
      tv_series
    end
  }

  scope :top_view, ->{order("num_view DESC")}
  scope :top_updated, ->{order("created_at DESC")}
  scope :top_comment, ->{order("comment_count DESC")}
  scope :top_rate, ->{order("rate_point DESC")}
  scope :top_movie_by, ->(type){
    case type
    when "top_view"
      top_view
    when "lastest_trailer"
      top_updated
    when "top_rated"
      top_rate
    when "top_comment"
      top_comment
    end
  }

  scope :genre, ->(genre_id) {joins(:genres).where "genres.id IN (?)", genre_id}
  scope :origin, ->(origin_id) {joins(:origins).where "origins.id IN (?)", origin_id}

  enum released_episodes_status: [:unreleased, :released]

  def self.update_stat_info!
    self.find_in_batches do |films|
      sleep(5)
      films.each do |film|
        released_episodes_status = film.released_all_episodes? ? 1 : 0
        film.update_attributes(comment_count: film.comment_cal, rate_point: film.rate_cal)
      end
    end
  end


  def comment_cal
  	comments.count
  end

  def movie?
    num_ep == Settings.film.movie.to_i
  end

  def rate_cal
  	average(:rate).present? ? average(:rate).avg : 0
  end

  def released_all_episodes?
    self.num_ep == self.episodes.size
  end
end
