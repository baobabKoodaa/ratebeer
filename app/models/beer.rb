class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  include Average

  def getRatingCount
    ratings.count
  end

  def to_s
    "#{self.name} by #{brewery.name}"
  end
end
