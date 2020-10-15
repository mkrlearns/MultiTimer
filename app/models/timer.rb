class Timer < ActiveRecord::Base

  def self.get_seconds(minutes = 0, seconds = 0)
    (minutes.to_i * 60) + seconds.to_i
  end

  belongs_to :user
end
