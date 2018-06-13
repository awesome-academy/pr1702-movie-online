class AddReleasedEpisodesStatusToFilm < ActiveRecord::Migration[5.0]
  def change
    add_column :films, :released_episodes_status, :integer
  end
end
