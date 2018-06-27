class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :set_locale, :default_url_options
  before_action :load_search, :load_origins, :load_genres, :load_notifications
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def load_search
  	@q = Film.ransack(params[:q])
  end

  def load_origins
    @origins = Origin.all
  end

  def load_genres
    @genres = Genre.all
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def load_notifications
    if current_user
      @notifications = current_user.notifications.reverse
    end
  end
end
