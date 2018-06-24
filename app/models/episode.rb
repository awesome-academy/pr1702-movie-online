class Episode < ApplicationRecord
  belongs_to :film
  has_many :link_episodes
  scope :sort_episodes, ->{order("num_epi ASC")}

  def link_exist?
    link_episodes.any?
  end

  def get_link(quality=0)
    link_by_quality = link_episodes.find_by(quality: quality)
    if link_by_quality.present?
      link_by_quality.link
    else
      link_episodes.last.link
    end
  end
end
