class Rating < ActiveRecord::Base
  belongs_to :beer
  include Enumerable

  def to_s
    "#{beer.name} #{self.score}"
  end

end
