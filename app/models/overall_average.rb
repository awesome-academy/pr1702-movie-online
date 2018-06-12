class OverallAverage < ActiveRecord::Base
  belongs_to :rateable, polymorphic: true

  def self.instance_method_already_implemented?(method_name)
    return true if method_name == "overall_avg"
    super
  end
end

